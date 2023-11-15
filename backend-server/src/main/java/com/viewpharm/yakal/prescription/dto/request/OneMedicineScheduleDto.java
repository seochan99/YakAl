package com.viewpharm.yakal.prescription.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.annotation.Nullable;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.util.List;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class OneMedicineScheduleDto {


    @JsonProperty("KDCode")
    private String KDCode;


    @JsonProperty("ATCCode")
    private String ATCCode;

    @Nullable
    private String customName;

    @Valid
    @NotNull
    @Size(min = 1)
    private List<OneScheduleDto> schedules;
}
