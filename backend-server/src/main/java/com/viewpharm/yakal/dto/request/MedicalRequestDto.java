package com.viewpharm.yakal.dto.request;

import com.viewpharm.yakal.dto.PointDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class MedicalRequestDto {
    PointDto location;
    Double distance;
}
