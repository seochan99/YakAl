package com.viewpharm.yakal.desire.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class DesireListDto {
    String content;
    String date;

    @Builder
    public DesireListDto(String content, String date) {
        this.content = content;
        this.date = date;
    }
}
