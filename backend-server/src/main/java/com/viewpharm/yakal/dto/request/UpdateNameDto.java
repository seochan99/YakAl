package com.viewpharm.yakal.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateNameDto {

    @NotBlank
    private String nickname;
}
