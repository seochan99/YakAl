package com.viewpharm.yakal.dto.request;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

//메시지 제목, 내용, 유저 아이디용 dto
//알림을 누구한테 보내는지에 대한 정보 필요할때
@Getter
@NoArgsConstructor
public class NotificationUserRequestDto {
    private Long targetUserId;
    private String title;
    private String body;

    @Builder
    public NotificationUserRequestDto(Long targetUserId, String title, String body) {
        this.targetUserId = targetUserId;
        this.title = title;
        this.body = body;
    }
}
