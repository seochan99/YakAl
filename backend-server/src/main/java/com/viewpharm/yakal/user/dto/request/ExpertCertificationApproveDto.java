package com.viewpharm.yakal.user.dto.request;

import com.viewpharm.yakal.base.type.EJob;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ExpertCertificationApproveDto {
    @NotNull
    private Boolean isApproval;

    @NotNull @Size(min = 1)
    private String department;

    @Enumerated(EnumType.STRING)
    private EJob job;
}
