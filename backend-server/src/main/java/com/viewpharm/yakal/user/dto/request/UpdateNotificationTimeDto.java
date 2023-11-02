package com.viewpharm.yakal.user.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalTime;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateNotificationTimeDto {
    @NotNull
    private String timezone;
    private LocalTime time;
}
