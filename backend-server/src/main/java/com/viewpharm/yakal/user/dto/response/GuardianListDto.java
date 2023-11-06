package com.viewpharm.yakal.user.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class GuardianListDto {
    Long id;
    String name;
    String birthday;

    @Builder
    public GuardianListDto(Long id, String name, String birthday) {
        this.id = id;
        this.name = name;
        this.birthday = birthday;
    }
}
