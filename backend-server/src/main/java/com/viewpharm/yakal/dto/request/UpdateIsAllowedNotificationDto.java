package com.viewpharm.yakal.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateIsAllowedNotificationDto {

    @NotNull
    private Boolean isAllowedNotification;
}
