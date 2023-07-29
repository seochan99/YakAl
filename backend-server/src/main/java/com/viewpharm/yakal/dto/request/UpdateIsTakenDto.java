package com.viewpharm.yakal.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateIsTakenDto {

    @NotNull
    private Boolean isTaken;

    @Builder
    public UpdateIsTakenDto(final Boolean isTaken) {
        this.isTaken = isTaken;
    }
}
