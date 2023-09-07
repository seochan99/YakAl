package com.viewpharm.yakal.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class PageInfo {
    private int page; // 페이지 개수
    private int size; // 페이지 당 데이터 개수
    private int totalElements; // 총 데이터 수
    private int totalPages; // 총 페이지 수
}
