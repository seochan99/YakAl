package com.viewpharm.yakal.dto;

import com.viewpharm.yakal.type.EDosingTime;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class DoesRequestDto {
    private LocalDate date;
    private EDosingTime time;
    private String pillName;
    private int pillCnt;
    private Boolean isHalf;
    private Long prescriptionId;
}
