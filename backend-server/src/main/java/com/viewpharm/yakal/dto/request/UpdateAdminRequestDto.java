package com.viewpharm.yakal.dto.request;

import com.viewpharm.yakal.base.type.EJob;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateAdminRequestDto {
    @NotNull
    private Boolean isAllow;

    @Min(1)
    private Long registrationId;

    @Enumerated(EnumType.STRING)
    private EJob job;
}
