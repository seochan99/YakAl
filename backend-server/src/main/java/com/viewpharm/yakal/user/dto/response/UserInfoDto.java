package com.viewpharm.yakal.user.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class UserInfoDto {
    private final String Nickname;
    private Boolean isDetail;
    private Boolean notiIsAllowed;
    private String breakfastTime;
    private String lunchTime;
    private String dinnerTime;
    private Long AnswerCount;
}
