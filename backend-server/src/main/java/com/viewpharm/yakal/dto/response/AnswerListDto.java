package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class AnswerListDto {
    String title;
    int result;

    @Builder
    public AnswerListDto(String title, int result) {
        this.title = title;
        this.result = result;
    }
}
