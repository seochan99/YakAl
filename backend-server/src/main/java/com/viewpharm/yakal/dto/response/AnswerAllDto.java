package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
public class AnswerAllDto {
    private List<AnswerListDto> datalist;
    private int percent;

    @Builder
    public AnswerAllDto(List<AnswerListDto> datalist, int percent) {
        this.datalist = datalist;
        this.percent = percent;
    }
}
