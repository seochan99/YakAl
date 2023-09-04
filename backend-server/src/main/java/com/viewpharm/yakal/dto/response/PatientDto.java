package com.viewpharm.yakal.dto.response;

import com.viewpharm.yakal.type.ESex;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;

@Getter
public class PatientDto {
    private Long id;
    private String name;
    private ESex sex;
    private LocalDate birthday;
    private int testProgress;
    private DoseCountDto doseCount;

    @Builder
    public PatientDto(Long id, String name, ESex sex, LocalDate birthday, int testProgress, DoseCountDto doseCount) {
        this.id = id;
        this.name = name;
        this.sex = sex;
        this.birthday = birthday;
        this.testProgress = testProgress;
        this.doseCount = doseCount;
    }
}
