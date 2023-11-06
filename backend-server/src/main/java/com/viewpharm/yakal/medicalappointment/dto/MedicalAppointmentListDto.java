package com.viewpharm.yakal.medicalappointment.dto;

import lombok.Builder;

import java.time.LocalDate;

public record MedicalAppointmentListDto(Long id, String name, String medicalEstablishmentName, String sharedDate) {
    @Builder
    public MedicalAppointmentListDto {
    }
}
