package com.viewpharm.yakal.dto.request;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
//메시지 제목, 내용, 유저Id용 dto
//내만산 코드 다시 읽어보니 얘 필요없음;;
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
