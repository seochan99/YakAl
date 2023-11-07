package com.viewpharm.yakal.prescription.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class CreatePrescriptionDto {
    private String pharmacyName;
    private LocalDate prescribedDate;
    private Boolean isAllow;
}
