package com.viewpharm.yakal.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;

@RestController
@RequestMapping("/api/dose")
@Tag(name = "Dose", description = "환자의 복용 정보 추가, 열람, 수정, 삭제")
public class DoseController {
}
