package com.viewpharm.yakal.medicalappointment.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PatientBaseInfoDto {
    String name;
    LocalDate birthday;
    String tel;
}