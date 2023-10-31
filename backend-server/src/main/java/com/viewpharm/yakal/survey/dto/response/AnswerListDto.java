package com.viewpharm.yakal.survey.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class AnswerListDto {
    Long id;
    String title;
    int result;
    String resultComment;

    @Builder
    public AnswerListDto(Long id, String title, int result, String resultComment) {
        this.id = id;
        this.title = title;
        this.result = result;
        this.resultComment = resultComment;
    }
}
