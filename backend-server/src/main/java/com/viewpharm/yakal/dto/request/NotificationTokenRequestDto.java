package com.viewpharm.yakal.dto.request;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
//메시지 제목, 내용, 디바이스 토큰용 dto
//알림 정보들 여기 받아와서 보냄
@Getter
@NoArgsConstructor
public class NotificationTokenRequestDto {
    private String targetToken; //추가
    private String title; //추가
    private String body; //수정

    @Builder
    public NotificationTokenRequestDto(String targetToken, String title, String body) {
        this.targetToken = targetToken;
        this.title = title;
        this.body = body;
    }
}
