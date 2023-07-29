package com.viewpharm.yakal.dto;

import lombok.Builder;
import lombok.Getter;
import java.sql.Timestamp;

//Notification 엔티티 정보 가져오기 위한 dto
@Builder
@Getter
public class NotificationDto {
    private Long id;
    private String title;
    private String content;
    private Boolean isRead;
    private Timestamp createdDate;

    public NotificationDto(Long id, String title, String content, Boolean isRead, Timestamp createdDate) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.isRead = isRead;
        this.createdDate = createdDate;
    }
}
