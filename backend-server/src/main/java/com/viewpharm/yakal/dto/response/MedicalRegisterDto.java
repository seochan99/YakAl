package com.viewpharm.yakal.dto.response;

import com.viewpharm.yakal.base.type.EMedical;
import com.viewpharm.yakal.base.type.ERecive;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MedicalRegisterDto {
    @Enumerated(EnumType.STRING)
    private EMedical medicalType;
    @NotNull
    private String directorName;
    @NotNull
    private String directorTel;
    @NotNull
    private String medicalName;
    @NotNull
    private String medicalTel;
    @NotNull
    private String zipCode;
    @NotNull
    private String medicalAddress;
    private String medicalDetailAddress;
    @NotNull
    private String businessRegistrationNumber;
    private String imagePath;
    @Enumerated(EnumType.STRING)
    private ERecive reciveType;
    private String medicalRuntime;
    private String medicalCharacteristics;
}
