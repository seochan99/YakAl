package com.viewpharm.yakal.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

//메시지 제목, 내용, 디바이스 토큰용 dto
//어떤 디바이스에 알림보내야하는지에 대한 정보
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class NotificationTokenRequestDto {
    private String targetToken; //추가
    private String title; //추가
    private String body; //수정
}
