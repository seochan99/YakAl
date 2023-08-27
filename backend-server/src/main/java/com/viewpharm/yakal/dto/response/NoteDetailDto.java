package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class NoteDetailDto {
    private Long id;
    private String title;
    private String description;
//    private Boolean isEdit;
//    private LocalDateTime createDate;
//    private LocalDateTime lastModifiedDate;

    @Builder
    public NoteDetailDto(Long id, String title, String description) {
        this.id = id;
        this.title = title;
        this.description = description;
    }
}
