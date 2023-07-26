package com.viewpharm.yakal.dto.request;

import com.viewpharm.yakal.type.EDosingTime;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@NoArgsConstructor
public class NotificationTestRequestDto {
    LocalDate localDate;
    EDosingTime eDosingTime;

    @Builder
    public NotificationTestRequestDto(LocalDate localDate, EDosingTime eDosingTime) {
        this.localDate = localDate;
        this.eDosingTime = eDosingTime;
    }
}
