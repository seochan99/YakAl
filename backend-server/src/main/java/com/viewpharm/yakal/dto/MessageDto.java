package com.viewpharm.yakal.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

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
