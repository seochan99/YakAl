package com.viewpharm.yakal.base.type;

import com.fasterxml.jackson.annotation.JsonCreator;

public enum EDisease {
    감기몸살, 눈질환, 기타질환, 남성질환, 만성질환, 소아진료,
    소화기질환, 여성질환, 정신질환, 치아, 통증, 피부질환, 암관련질환;

    @JsonCreator
    public static EDisease from(String value) {
        for (EDisease disease : EDisease.values()) {
            if (disease.toString().equals(value)) {
                return disease;
            }
        }
        return null;
    }
}
