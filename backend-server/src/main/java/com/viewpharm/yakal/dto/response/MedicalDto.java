package com.viewpharm.yakal.dto.response;

import com.viewpharm.yakal.dto.PointDto;
import com.viewpharm.yakal.type.EMedical;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MedicalDto {
    private Long id;
    private String medicalName;
    private String medicalAddress;
    private String medicalTel;
    private PointDto medicalPoint;
    private EMedical eMedical;

    private boolean isRegister;

    @Builder
    public MedicalDto(Long id, String medicalName, String medicalAddress, String medicalTel, PointDto medicalPoint, EMedical eMedical, boolean isRegister) {
        this.id = id;
        this.medicalName = medicalName;
        this.medicalAddress = medicalAddress;
        this.medicalTel = medicalTel;
        this.medicalPoint = medicalPoint;
        this.eMedical = eMedical;
        this.isRegister = isRegister;
    }
}
