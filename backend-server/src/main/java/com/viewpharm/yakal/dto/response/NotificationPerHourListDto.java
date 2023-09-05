package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class NotificationPerHourListDto {
    String date;
    Long count;

    @Builder
    public NotificationPerHourListDto(String date, Long count) {
        this.date = date;
        this.count = count;
    }
}
