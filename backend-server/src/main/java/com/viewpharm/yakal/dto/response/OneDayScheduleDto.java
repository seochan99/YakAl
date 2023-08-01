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
    //private Map<EDosingTime, List<>> overlap;

    /* {
        morning : [
            {
                atccode : atccodename,
                kdcodes : [kd1,kd2]
            },
        ]
        afternoon :
        evening :

        }
    */
    @Builder
    public OneDayScheduleDto(final LocalDate date, final Map<EDosingTime, List<OneTimeScheduleDto>> schedule) {
        this.date = date;
        this.schedule = schedule;
    }
}
