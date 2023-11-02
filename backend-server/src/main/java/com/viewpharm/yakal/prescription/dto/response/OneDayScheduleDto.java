package com.viewpharm.yakal.prescription.dto.response;

import com.viewpharm.yakal.base.type.EDosingTime;
import lombok.Builder;
import lombok.Getter;

import java.util.List;
import java.util.Map;

@Getter
public class OneDayScheduleDto {

    private String date;
    private Long totalCnt;
    private Map<EDosingTime, List<OneTimeScheduleDto>> schedule;
    private Map<EDosingTime,List<OverlapDto>> overlap;
    @Builder
    public OneDayScheduleDto(String date,  Long totalCnt, Map<EDosingTime,List<OneTimeScheduleDto>> schedule, Map<EDosingTime, List<OverlapDto>> overlap) {
        this.date = date;
        this.totalCnt = totalCnt;
        this.schedule = schedule;
        this.overlap = overlap;
    }
}
