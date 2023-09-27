package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;
//건강기능 식품 비타민 변경 예정
@Deprecated
@Getter
public class HealthFoodListDto {
    private Long id;
    private String name;

    @Builder
    public HealthFoodListDto(Long id, String name) {
        this.id = id;
        this.name = name;
    }
}
