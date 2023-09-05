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
    private LocalDate lastSurbey;

    @Builder
    public PatientDto(Long id, String name, ESex sex, LocalDate birthday, int testProgress, LocalDate lastSurbey) {
        this.id = id;
        this.name = name;
        this.sex = sex;
        this.birthday = birthday;
        this.testProgress = testProgress;
        this.lastSurbey = lastSurbey;
    }
}
