package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
public class BoardDetailDto {
    private Long id;
    private String title;
    private String content;
    private String userName;
    private Boolean isEdit;
    private Boolean isLike;
    private Long readCnt;
    private Long userId;
    private Long likeCnt;
    private String region;
    private String createDate;
    private String lastModifiedDate;

    @Builder
    public BoardDetailDto(Long id, String title, String content, String userName, Boolean isEdit, Boolean isLike, Long readCnt, Long userId, Long likeCnt, String region, String createDate, String lastModifiedDate) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.userName = userName;
        this.isEdit = isEdit;
        this.isLike = isLike;
        this.readCnt = readCnt;
        this.userId = userId;
        this.likeCnt = likeCnt;
        this.region = region;
        this.createDate = createDate;
        this.lastModifiedDate = lastModifiedDate;
    }
}
