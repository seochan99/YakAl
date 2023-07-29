package com.viewpharm.yakal.dto.request;

import com.viewpharm.yakal.annotation.Date;
import com.viewpharm.yakal.annotation.Enum;
import com.viewpharm.yakal.type.EDosingTime;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Setter
@Getter
public class OneScheduleDto {

    @Date
    @NotNull
    private LocalDate date;

    @NotNull
    @Enum(enumClass = EDosingTime.class)
    private EDosingTime time;

    @NotNull
    @DecimalMin("0.0")
    private Double count;

    @Builder
    public OneScheduleDto(final LocalDate date, final EDosingTime time, final Double count) {
        this.date = date;
        this.time = time;
        this.count = count;
    }
}
