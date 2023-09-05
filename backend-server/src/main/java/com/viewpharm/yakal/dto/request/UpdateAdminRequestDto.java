package com.viewpharm.yakal.dto.request;

import com.viewpharm.yakal.type.EJob;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateAdminRequestDto {
    @NotNull
    private Boolean isAllow;
    private Long registrationId;
    private EJob job;
}
