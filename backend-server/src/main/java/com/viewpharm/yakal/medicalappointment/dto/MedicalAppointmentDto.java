package com.viewpharm.yakal.medicalappointment.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class MedicalAppointmentDto {
    private Long id;
    private String name;

    @Builder
    public MedicalAppointmentDto(Long id, String name) {
        this.id = id;
        this.name = name;
    }
}
