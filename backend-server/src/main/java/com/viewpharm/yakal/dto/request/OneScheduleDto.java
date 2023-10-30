package com.viewpharm.yakal.dto.request;

import com.viewpharm.yakal.common.annotation.Enum;
import com.viewpharm.yakal.base.type.EDosingTime;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class OneScheduleDto {

    @NotNull
    private LocalDate date;

    @NotNull
    @Enum(enumClass = EDosingTime.class)
    private EDosingTime time;

    @NotNull
    @DecimalMin("0.0")
    private Double count;
}
