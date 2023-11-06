package com.viewpharm.yakal.user.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;

@Getter
public class UserListDtoForGuardian {
    Long id;
    String nickname;
    String birthday;

    @Builder
    public UserListDtoForGuardian(Long id, String nickname, String birthday) {
        this.id = id;
        this.nickname = nickname;
        this.birthday = birthday;
    }
}
