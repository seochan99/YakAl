package com.viewpharm.yakal.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateIsAllowedNotificationDto {

    @NotNull
    private Boolean isAllowedNotification;

    @Builder
    public UpdateIsAllowedNotificationDto(final Boolean isAllowedNotification) {
        this.isAllowedNotification = isAllowedNotification;
    }
}
