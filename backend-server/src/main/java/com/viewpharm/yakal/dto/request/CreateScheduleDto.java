package com.viewpharm.yakal.dto.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CreateScheduleDto {

    @Min(1)
    @NotNull
    private Long prescriptionId;

    @Valid
    @NotNull
    @Size(min = 1)
    private List<OneMedicineScheduleDto> medicines;

    @Builder
    public CreateScheduleDto(final Long prescriptionId, final List<OneMedicineScheduleDto> medicines) {
        this.prescriptionId = prescriptionId;
        this.medicines = medicines;
    }
}
