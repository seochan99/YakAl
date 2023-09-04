package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class DoseCountDto {
    private int red;
    private int yellow;
    private int green;

    @Builder
    public DoseCountDto(int red, int yellow, int green) {
        this.red = red;
        this.yellow = yellow;
        this.green = green;
    }
}
