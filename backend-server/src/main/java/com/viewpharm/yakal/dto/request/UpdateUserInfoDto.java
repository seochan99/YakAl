package com.viewpharm.yakal.dto.request;

import com.viewpharm.yakal.annotation.Date;
import com.viewpharm.yakal.annotation.Enum;
import com.viewpharm.yakal.type.ESex;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateUserInfoDto {

    @NotBlank
    private String nickname;

    @NotNull
    private Boolean isDetail;

    @Date
    @Past
    @NotNull
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate birthday;

    @NotNull
    @Enum(enumClass = ESex.class)
    private ESex sex;
}
