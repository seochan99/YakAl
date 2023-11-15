package com.viewpharm.yakal.desire.dto.request;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class DesireRequestDto {

    @NotNull
    @Size(min = 1)
    String content;
}
