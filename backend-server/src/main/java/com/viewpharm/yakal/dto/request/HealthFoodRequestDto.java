package com.viewpharm.yakal.dto.request;

import lombok.Builder;
import lombok.Getter;

@Getter
public class HealthFoodRequestDto {
    private String name;

    @Builder
    public HealthFoodRequestDto(String name) {
        this.name = name;
    }
}
