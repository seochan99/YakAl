package com.viewpharm.yakal.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/medicine")
@Tag(name = "Medicine", description = "약제 정보 열람")
public class MedicineController {
}
