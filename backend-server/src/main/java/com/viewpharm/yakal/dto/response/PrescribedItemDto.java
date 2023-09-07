package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.time.LocalDate;

@Getter
@Builder
@RequiredArgsConstructor
public class PrescribedItemDto {

    private final String name;
    private final Integer score;
    private final LocalDate prescribedDate;
}
