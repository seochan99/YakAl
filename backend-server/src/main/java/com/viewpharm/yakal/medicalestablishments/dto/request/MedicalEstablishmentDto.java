package com.viewpharm.yakal.medicalestablishments.dto.request;

import com.viewpharm.yakal.base.type.EMedical;
import com.viewpharm.yakal.medicalestablishments.domain.MedicalEstablishment;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class MedicalEstablishmentDto {
    @NotNull
    @Size(min = 1)
    private EMedical type;
    @NotNull
    @Size(min = 1)
    private String chiefName;
    @NotNull
    @Size(min = 1)
    private String chiefTel;
    @NotNull
    @Size(min = 1)
    private String facilityName;
    @NotNull
    @Size(min = 1)
    private String facilityNumber;
    @NotNull
    @Size(min = 1)
    private String zipCode;
    @NotNull
    @Size(min = 1)
    private String address;
    @NotNull
    @Size(min = 1)
    private String businessRegiNumber;

    private String tel;
    private String clinicHours;
    private String features;

    public MedicalEstablishment toEntity(String uuidImageName) {
        return MedicalEstablishment.builder()
                .type(type)
                .chiefName(chiefName)
                .chiefTel(chiefTel)
                .name(facilityName)
                .establishmentNumber(facilityNumber)
                .zipCode(zipCode)
                .address(address)
                .businessNumber(businessRegiNumber)
                .tel(tel)
                .clinicHours(clinicHours)
                .features(features)
                .chiefLicenseImg(uuidImageName)
                .build();
    }
}
