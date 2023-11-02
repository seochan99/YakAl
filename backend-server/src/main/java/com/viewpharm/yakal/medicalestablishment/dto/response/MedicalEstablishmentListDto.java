package com.viewpharm.yakal.medicalestablishment.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class MedicalEstablishmentListDto {
    private Long id;
    private String name;
    private String address;
}
