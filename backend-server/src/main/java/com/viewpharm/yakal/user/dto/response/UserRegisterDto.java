package com.viewpharm.yakal.user.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@Builder
@RequiredArgsConstructor
public class UserRegisterDto {
    private final String name;
    private final Boolean isDetail;
    private final Boolean isOptionalAgreementAccepted;
    private final Boolean isIdentified;
}
