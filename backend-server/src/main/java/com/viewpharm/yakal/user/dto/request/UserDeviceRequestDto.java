package com.viewpharm.yakal.user.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class UserDeviceRequestDto {
    private String device_token;
    private Boolean is_ios;
}