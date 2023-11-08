package com.viewpharm.yakal.prescription.dto.request;

import jakarta.annotation.Nullable;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.util.List;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class CreateScheduleDto {

    @Nullable
    private Long prescriptionId;

    @Valid
    @NotNull
    @Size(min = 1)
    private List<OneMedicineScheduleDto> medicines;
}
