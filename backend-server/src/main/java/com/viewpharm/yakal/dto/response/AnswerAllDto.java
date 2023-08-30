package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
public class AnswerAllDto {
    private List<AnswerListDto> data;
    private int percent;

    @Builder
    public AnswerAllDto(List<AnswerListDto> data, int percent) {
        this.data = data;
        this.percent = percent;
    }
}
