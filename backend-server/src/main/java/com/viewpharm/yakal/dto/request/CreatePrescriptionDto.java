package com.viewpharm.yakal.dto.request;

import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class CreatePrescriptionDto {
    private String pharmacyName;
    private LocalDate prescribedDate;
}
