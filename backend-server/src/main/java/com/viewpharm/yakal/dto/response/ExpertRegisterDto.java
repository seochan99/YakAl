package com.viewpharm.yakal.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.LocalDate;

@Getter
@AllArgsConstructor
public class ExpertRegisterDto {
    private Long medicalId;
    private String name;
    private LocalDate birthday;
    private String expertPath;
    private String medicalPath;
    private LocalDate requestDate;
}
