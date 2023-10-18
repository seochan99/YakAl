package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;

@Getter
public class UserListDtoForGuardian {
    Long id;
    String name;
    String birthday;

    @Builder
    public UserListDtoForGuardian(Long id, String name, String birthday) {
        this.id = id;
        this.name = name;
        this.birthday = birthday;
    }
}
