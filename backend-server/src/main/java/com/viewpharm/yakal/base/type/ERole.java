package com.viewpharm.yakal.base.type;

import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Arrays;

@Getter
@AllArgsConstructor
public enum ERole {
    USER("ROLE_USER", "사용자"),
    DOCTOR("ROLE_DOCTOR", "의사"),
    PHARMACIST("ROLE_PHARMACIST", "약사"),
    ADMIN("ROLE_ADMIN", "관리자");

    private final String roleCode;
    private final String displayName;

    public static ERole of(String roleCode) {
        return Arrays.stream(ERole.values())
                .filter(v -> v.getRoleCode().equals(roleCode))
                .findAny()
                .orElseThrow(() -> new CommonException(ErrorCode.ACCESS_DENIED_ERROR));
    }

    @Override
    public String toString() {
        return roleCode;
    }
}
