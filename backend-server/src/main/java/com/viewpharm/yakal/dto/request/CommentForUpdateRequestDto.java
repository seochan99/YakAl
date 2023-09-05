package com.viewpharm.yakal.dto.request;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class CommentForUpdateRequestDto {
    @NotNull
    @Size(min = 1, max = 50)
    private String content;
}
