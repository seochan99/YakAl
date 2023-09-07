package com.viewpharm.yakal.dto.response;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.type.ERegion;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
public class BoardListDto {
    private Long id;
    private String title;
    private String content;
    private String userName;
    private ERegion region;
    private String lastModifiedDate;
    private Long readCnt;
    private Boolean isLike;

    @Builder
    public BoardListDto(Long id, String title, String content, String userName, ERegion region, String lastModifiedDate, Long readCnt, Boolean isLike) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.userName = userName;
        this.region = region;
        this.lastModifiedDate = lastModifiedDate;
        this.readCnt = readCnt;
        this.isLike = isLike;
    }
}
