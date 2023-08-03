package com.viewpharm.yakal.dto.request;

import com.viewpharm.yakal.dto.request.OneScheduleDto;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class OneMedicineScheduleDto {

    @NotBlank
    private String KDCode;

    @NotBlank
    private String ATCCode;

    @Valid
    @NotNull
    @Size(min = 1)
    private List<OneScheduleDto> schedules;
}
