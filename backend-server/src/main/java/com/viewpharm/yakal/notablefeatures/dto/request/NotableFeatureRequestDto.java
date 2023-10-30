package com.viewpharm.yakal.notablefeatures.dto.request;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class NotableFeatureRequestDto {
    @NotNull
    @Size(min = 1, max = 20)
    private String notableFeature;
}
