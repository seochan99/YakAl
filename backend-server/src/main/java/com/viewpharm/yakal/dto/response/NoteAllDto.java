package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
public class NoteAllDto {
    private List<NoteDetailDto> data;
    private PageInfo pageInfo;

    @Builder
    public NoteAllDto(List<NoteDetailDto> data, PageInfo pageInfo) {
        this.data = data;
        this.pageInfo = pageInfo;
    }
}
