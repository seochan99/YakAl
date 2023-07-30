package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class OneTimeScheduleDto {

    final Long id;
    final String pillName;
    final Boolean isTaken;
    final Boolean isOverlap;
    final Double count;
    final Long prescriptionId;
}
