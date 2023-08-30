package com.viewpharm.yakal.dto.response;

import com.viewpharm.yakal.type.EJob;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@RequiredArgsConstructor
public class UserExpertDto {
    final private String userName;
    final private EJob eJob;
    final private String department;
}
