package com.viewpharm.yakal.medicalrecord.dto.reqeust;

import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.jetbrains.annotations.NotNull;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class MedicalRecordDto {
    @NotNull
    @Size(min = 1)
    private String hospitalName;

    @NotNull
    @Size(min = 1)
    private String recodeDate;

    public java.sql.Date toSqlDate() {
        return java.sql.Date.valueOf(this.recodeDate);
    }
}
