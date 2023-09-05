package com.viewpharm.yakal.dto.response;

import com.viewpharm.yakal.type.EMedical;
import com.viewpharm.yakal.type.ERecive;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MedicalRegisterDto {
    private EMedical medicalType;
    private String directorName;
    private String directorTel;
    private String medicalName;
    private String medicalTel;
    private String zipCode;
    private String medicalAddress;
    private String medicalDetailAddress;
    private String businessRegistrationNumber;
    private String imagePath;
    private ERecive reciveType;
    private String medicalRuntime;
    private String medicalCharacteristics;
}
