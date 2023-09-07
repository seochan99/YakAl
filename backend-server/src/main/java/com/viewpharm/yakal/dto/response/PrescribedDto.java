package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.time.LocalDate;
import java.util.List;

@Getter
@Builder
public class PrescribedDto {

    private final List<PrescribedItemDto> prescribedList;
    private final Integer totalCount;

    public PrescribedDto(final List<PrescribedItemDto> prescribedList,final Integer totalCount ) {
        this.prescribedList = prescribedList;
        this.totalCount = totalCount;
    }
}
