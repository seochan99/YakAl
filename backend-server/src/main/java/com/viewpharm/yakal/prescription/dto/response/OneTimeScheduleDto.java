package com.viewpharm.yakal.prescription.dto.response;

import com.viewpharm.yakal.prescription.domain.Risk;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class OneTimeScheduleDto {

    final Long id;
    final String KDCode;
    final String dosename;
    final Risk ATCCode;
    final Boolean isTaken;
    final Boolean isOverlap;
    final Double count;
    final Long prescriptionId;
}
