package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
public class NoteDetailDto {
    private Long id;
    private String title;
    private String description;
    private LocalDate createDate;
//    private Boolean isEdit;
//    private LocalDateTime lastModifiedDate;

    @Builder
    public NoteDetailDto(Long id, String title, String description, LocalDate createDate) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.createDate = createDate;
    }
}
