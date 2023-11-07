package com.viewpharm.yakal.medicalestablishment.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ExpertCertificationListDto {
    private Long id;
    private String name;
    private String type;
    private String belong;
    private String tel;
    private LocalDate requestedAt;
}
