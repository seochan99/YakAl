package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.YearMonth;

@Getter
public class LoginLogListForMonthDto {
    String date;
    Long count;

    @Builder
    public LoginLogListForMonthDto(String date, Long count) {
        this.date = date;
        this.count = count;
    }
}
