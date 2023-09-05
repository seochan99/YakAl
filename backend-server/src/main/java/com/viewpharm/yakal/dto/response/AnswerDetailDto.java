package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class AnswerDetailDto {
    String title;
    String content;
    int result;

    @Builder
    public AnswerDetailDto(String title, String content, int result) {
        this.title = title;
        this.content = content;
        this.result = result;
    }
}
