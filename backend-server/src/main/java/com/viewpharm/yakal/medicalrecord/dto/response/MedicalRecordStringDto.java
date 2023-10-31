package com.viewpharm.yakal.medicalrecord.dto.response;

import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.jetbrains.annotations.NotNull;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class MedicalRecordStringDto {
    @NotNull
    private Long id;

    @NotNull
    @Size(min = 1)
    private String hospitalName;

    @NotNull
    @Size(min = 1)
    private String recodeDate;
}
