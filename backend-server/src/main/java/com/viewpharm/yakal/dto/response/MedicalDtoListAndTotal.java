package com.viewpharm.yakal.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

@Getter
@AllArgsConstructor
public class MedicalDtoListAndTotal {
    List MedicalDto;
    Long total;
}
