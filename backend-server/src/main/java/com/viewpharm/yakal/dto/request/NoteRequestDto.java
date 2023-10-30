package com.viewpharm.yakal.dto.request;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class NoteRequestDto {
    @NotNull @Size(min = 1, max = 20)
    String title;

    @NotNull@Size(min = 1, max = 255)
    String description;
}
