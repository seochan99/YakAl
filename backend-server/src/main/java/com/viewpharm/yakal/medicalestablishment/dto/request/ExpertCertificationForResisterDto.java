package com.viewpharm.yakal.medicalestablishment.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ExpertCertificationForResisterDto {
    private Long id;
    private Boolean isApproval;
    private String department;

}
