package com.viewpharm.yakal.user.dto.response;

import com.viewpharm.yakal.base.type.ESex;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;

@Getter
public class PatientDto {
    private Long id;
    private String name;
    private ESex sex;
    private LocalDate birthday;
    private LocalDate lastQuestionnaireDate;
    private String tel;
    private Boolean isFavorite;

    @Builder
    public PatientDto(Long id, String name, ESex sex, LocalDate birthday, LocalDate lastQuestionnaireDate, String tel, Boolean isFavorite) {
        this.id = id;
        this.name = name;
        this.sex = sex;
        this.birthday = birthday;
        this.lastQuestionnaireDate = lastQuestionnaireDate;
        this.tel = tel;
        this.isFavorite = isFavorite;
    }
}
