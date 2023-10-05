package com.viewpharm.yakal.dto.request;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class AnswerRequestDto {
    @NotNull
    @Size(min = 1)
    private String content;

    @NotNull
    @Min(0)
    private int score;
}
