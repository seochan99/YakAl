package com.viewpharm.yakal.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateUserInfoDto {

    @NotBlank
    private String nickname;

    @NotNull
    private Boolean isDetail;
}
