package com.viewpharm.yakal.guardian.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class GuardianDto {
    Long id;
    String name;
    String tel;
    String birthDay;

    @Builder
    public GuardianDto(Long id, String name, String tel, String birthDay) {
        this.id = id;
        this.name = name;
        this.tel = tel;
        this.birthDay = birthDay;
    }
}
