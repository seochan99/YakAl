package com.viewpharm.yakal.dto.request;

import com.viewpharm.yakal.type.EJob;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.Min;
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

    @Min(1)
    private Long registrationId;

    @Enumerated(EnumType.STRING)
    private EJob job;
}
