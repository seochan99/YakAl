package com.viewpharm.yakal.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateNameDto {

    @NotBlank
    private String nickname;
}
