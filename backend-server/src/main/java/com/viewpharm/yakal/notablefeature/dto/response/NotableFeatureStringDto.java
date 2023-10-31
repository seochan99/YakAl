package com.viewpharm.yakal.notablefeature.dto.response;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class NotableFeatureStringDto {
    @NotNull
    private Long id;
    @NotNull
    private String name;
}
