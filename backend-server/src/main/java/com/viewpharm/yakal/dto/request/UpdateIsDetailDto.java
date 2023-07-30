package com.viewpharm.yakal.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateIsDetailDto {

    @NotNull
    private Boolean isDetail;
}
