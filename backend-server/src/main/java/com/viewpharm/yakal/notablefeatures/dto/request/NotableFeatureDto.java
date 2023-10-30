package com.viewpharm.yakal.notablefeatures.dto.request;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class NotableFeatureDto {
    @NotNull
    @Size(min = 1, max = 20)
    private String notableFeature;

    public Date toSqlDate() {
        return Date.valueOf(this.notableFeature);
    }
}
