package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;
@Getter
public class LoginLogListDto {
    LocalDate date;
    Long count;

    @Builder
    public LoginLogListDto(LocalDate date, Long count) {
        this.date = date;
        this.count = count;
    }
}
