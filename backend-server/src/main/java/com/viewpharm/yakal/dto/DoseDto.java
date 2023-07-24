package com.viewpharm.yakal.dto;

import com.viewpharm.yakal.type.EDosingTime;
import lombok.Builder;
import lombok.Getter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Getter
public class DoseDto {

    private Map<EDosingTime, List<Pill>> dosesByTime = new HashMap<>();
    @Builder
    @Getter
    public static class Pill{
        final Long id;
        final String pillName;
        final Boolean isTaken;
        final int cnt;
        final boolean isHalf;
    }

    @Builder
    public DoseDto(Map<EDosingTime, List<Pill>> dosesByTime) {
        this.dosesByTime = dosesByTime;
    }
}
