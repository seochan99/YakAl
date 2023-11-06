package com.viewpharm.yakal.prescription.dto.request;

import com.viewpharm.yakal.base.annotation.Enum;
import com.viewpharm.yakal.base.type.EDosingTime;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;
import java.util.List;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class OneScheduleDto {

    @NotNull
    private LocalDate date;

    @NotNull
    private List<Boolean> time;

    @NotNull
    @DecimalMin("0.0")
    private Double count;
}
