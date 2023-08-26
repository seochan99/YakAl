package com.viewpharm.yakal.dto.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CreateScheduleDto {

    @Min(1)
    @NotNull
    private Long prescriptionId;

    @Valid
    @NotNull
    @Size(min = 1)
    private List<OneMedicineScheduleDto> medicines;
}
