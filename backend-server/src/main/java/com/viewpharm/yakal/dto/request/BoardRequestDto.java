package com.viewpharm.yakal.dto.request;

import com.viewpharm.yakal.type.ERegion;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class BoardRequestDto {
    private String title;
    private String content;
    private ERegion region;

}
