package com.viewpharm.yakal.guardian.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class GuardianTelDto {
    Long id;
    String realName;
    String tel;

    @Builder
    public GuardianTelDto(Long id, String realName, String tel) {
        this.id = id;
        this.realName = realName;
        this.tel = tel;
    }
}
