package com.viewpharm.yakal.user.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateIsOptionalAgreementDto {
    @NotNull
    private Boolean isOptionalAgreementAccepted;
}
