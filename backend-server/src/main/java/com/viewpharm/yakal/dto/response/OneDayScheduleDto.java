package com.viewpharm.yakal.dto.response;

import com.viewpharm.yakal.type.EDosingTime;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Getter
public class OneDayScheduleDto {

    private LocalDate date;
    private Map<EDosingTime, List<OneTimeScheduleDto>> schedule;
    private Map<EDosingTime,List<OverlapDto>> overlap;
    @Builder
    public OneDayScheduleDto(LocalDate date, Map<EDosingTime, List<OneTimeScheduleDto>> schedule, Map<EDosingTime, List<OverlapDto>> overlap) {
        this.date = date;
        this.schedule = schedule;
        this.overlap = overlap;
    }
}
