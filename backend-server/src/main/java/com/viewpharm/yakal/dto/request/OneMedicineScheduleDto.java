package com.viewpharm.yakal.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
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
@NoArgsConstructor
public class OneMedicineScheduleDto {


    @JsonProperty("KDCode")
    private String KDCode;


    @JsonProperty("ATCCode")
    private String ATCCode;

    @Valid
    @NotNull
    @Size(min = 1)
    private List<OneScheduleDto> schedules;
}
