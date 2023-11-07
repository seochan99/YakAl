package com.viewpharm.yakal.medicalestablishment.dto.request;

import com.viewpharm.yakal.base.type.EMedical;
import com.viewpharm.yakal.medicalestablishment.domain.ExpertCertification;
import com.viewpharm.yakal.medicalestablishment.domain.MedicalEstablishment;
import com.viewpharm.yakal.user.domain.User;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ExpertCertificationDto {
    @NotNull
    @Size(min = 1)
    private EMedical type;
    @NotNull
    @Size(min = 1)
    private Long facilityId;

    public ExpertCertification toEntity(User user, MedicalEstablishment medicalEstablishment,
                                        String licenseImg, String affiliationImg) {
        return ExpertCertification.builder()
                .user(user)
                .medicalEstablishment(medicalEstablishment)
                .type(type)
                .licenseImg(licenseImg)
                .affiliationImg(affiliationImg)
                .build();
    }
}
