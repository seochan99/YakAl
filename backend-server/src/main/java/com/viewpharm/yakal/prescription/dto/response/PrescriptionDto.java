package com.viewpharm.yakal.prescription.dto.response;


import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.LocalDate;

@Getter
@AllArgsConstructor
public class PrescriptionDto {
    private Long id;
    private String pharmacyName;
    private String prescribedDate;
    private String createdDate;
}
