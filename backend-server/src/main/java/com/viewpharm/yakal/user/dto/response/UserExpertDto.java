package com.viewpharm.yakal.user.dto.response;

import com.viewpharm.yakal.base.type.EJob;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Builder
@RequiredArgsConstructor
public class UserExpertDto {

    final private String name;
    final private EJob job;
    final private String department;
    final private LocalDate birthday;
    final private String tel;
}