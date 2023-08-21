package com.viewpharm.yakal.type;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.Getter;

public enum ERegion {
    중구, 강서구, 강남구;


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
