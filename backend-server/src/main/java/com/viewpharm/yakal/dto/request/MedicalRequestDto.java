package com.viewpharm.yakal.dto.request;

import com.viewpharm.yakal.dto.PointDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class MedicalRequestDto {
    PointDto location;
    Double distance;
}
