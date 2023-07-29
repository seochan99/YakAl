package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class OneDayProgressDto {

    private LocalDate date;
    private Long progressOrNull;

    @Builder
    public OneDayProgressDto(final LocalDate date, final Long progressOrNull) {
        this.date = date;
        this.progressOrNull = progressOrNull;
    }
}
