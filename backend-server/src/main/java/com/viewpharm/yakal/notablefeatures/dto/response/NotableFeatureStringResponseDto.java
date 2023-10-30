package com.viewpharm.yakal.notablefeatures.dto.response;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class NotableFeatureStringResponseDto {
    @NotNull
    private Long id;
    @NotNull
    private String name;
}
