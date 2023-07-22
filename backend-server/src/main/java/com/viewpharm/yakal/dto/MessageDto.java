package com.viewpharm.yakal.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
//버전 1에서 메시지를 생성하기 위한 Dto
//버전 2하면 삭제
@Builder
@AllArgsConstructor
@Getter
public class MessageDto {
    private boolean validateOnly;
    private Message message;

    @Builder
    @AllArgsConstructor
    @Getter
    public static class Message {
        private MessageNotification messageNotification;
        private String token;
    }

    @Builder
    @AllArgsConstructor
    @Getter
    public static class MessageNotification {
        private String title;
        private String body;
        private String image;
    }

}
