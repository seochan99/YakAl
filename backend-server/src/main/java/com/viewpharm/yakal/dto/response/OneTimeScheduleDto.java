package com.viewpharm.yakal.dto.response;

import com.viewpharm.yakal.domain.Risk;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class OneTimeScheduleDto {

    final Long id;
    final String KDCode;
    final Risk ATCCode;
    final Boolean isTaken;
    final Boolean isOverlap;
    final Double count;
    final Long prescriptionId;
}
