package com.viewpharm.yakal.user.dto.request;

import com.viewpharm.yakal.base.type.EDosingTime;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateIsTakenDto {

    @NotNull
    private Boolean isTaken;
    private EDosingTime dosingTime;
}
