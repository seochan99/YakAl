package com.viewpharm.yakal.dto.request;

import com.viewpharm.yakal.type.ERegion;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class BoardRequestDto {
    @NotNull
    @Size(min = 1, max = 30)
    private String title;
    @NotNull
    @Size(min = 1, max = 255)
    private String content;
    @NotNull
    private String region;
}
