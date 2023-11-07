package com.viewpharm.yakal.prescription.dto.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.util.List;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class CreateScheduleDto {

    private Long prescriptionId;

    @Valid
    @NotNull
    @Size(min = 1)
    private List<OneMedicineScheduleDto> medicines;
}
