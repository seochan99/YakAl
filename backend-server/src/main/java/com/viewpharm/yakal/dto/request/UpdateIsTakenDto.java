package com.viewpharm.yakal.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateIsTakenDto {

    @NotNull
    private Boolean isTaken;
}
