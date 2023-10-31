package com.viewpharm.yakal.notablefeature.dto.response;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class NotableFeatureDateDto {
    @NotNull
    private Long id;
    @NotNull
    private List<Integer> date;
}
