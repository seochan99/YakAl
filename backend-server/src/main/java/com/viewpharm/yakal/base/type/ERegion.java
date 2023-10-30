package com.viewpharm.yakal.base.type;

import com.fasterxml.jackson.annotation.JsonCreator;

public enum ERegion {
    도봉구, 노원구, 강북구, 성북구, 중랑구, 은평구, 종로구, 동대문구,
    서대문구, 중구, 성동구, 광진구, 마포구, 용산구, 강서구, 양천구, 영등포구,
    동작구, 구로구, 금천구, 관악구, 서초구, 강남구, 송파구, 강동구;


    @JsonCreator
    public static ERegion from(String value) {
        for (ERegion region : ERegion.values()) {
            if (region.toString().equals(value)) {
                return region;
            }
        }
        return null;
    }
}
