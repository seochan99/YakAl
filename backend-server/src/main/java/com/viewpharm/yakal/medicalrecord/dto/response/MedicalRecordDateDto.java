package com.viewpharm.yakal.medicalrecord.dto.response;

import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.jetbrains.annotations.NotNull;

import java.util.List;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class MedicalRecordDateDto {
    @NotNull
    private Long id;

    @NotNull
    @Size(min = 1)
    private String hospitalName;

    @NotNull
    @Size(min = 1)
    private List<Integer> recodeDate;
}
