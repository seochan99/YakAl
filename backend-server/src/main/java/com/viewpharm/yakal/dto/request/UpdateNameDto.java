package com.viewpharm.yakal.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateNameDto {

    @NotBlank
    private String nickname;

    @Builder
    public UpdateNameDto(final String nickname) {
        this.nickname = nickname;
    }
}
