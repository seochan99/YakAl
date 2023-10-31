package com.viewpharm.yakal.survey.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class AnswerDetailDto {
    String title;
    int result;
    String content;

    @Builder
    public AnswerDetailDto(String title, String content, int result) {
        this.title = title;
        this.content = content;
        this.result = result;
    }
}
