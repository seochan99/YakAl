package com.viewpharm.yakal.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
public class PercentDto {

    private int percent;

    @Builder
    public PercentDto(int percent) {
        this.percent = percent;
    }
}
