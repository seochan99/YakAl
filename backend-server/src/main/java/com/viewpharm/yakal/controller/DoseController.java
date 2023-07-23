package com.viewpharm.yakal.controller;


import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.DoseDto;
import com.viewpharm.yakal.dto.PercentDto;
import com.viewpharm.yakal.dto.ResponseDto;
import com.viewpharm.yakal.service.DoseService;
import com.viewpharm.yakal.type.EDosingTime;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/dose")
@Tag(name = "Dose", description = "환자의 복용 정보 추가, 열람, 수정, 삭제")
public class DoseController {

    private final DoseService doseService;
    @GetMapping("/schedule/{yyyy}/{MM}/{dd}")
    @Operation(summary = "복용 스케줄 가져오기", description = "환자가 지정한 날짜에 복용해야 하는 약 목록을 가져온다.")
    public ResponseDto<DoseDto> getOneDayDoseSchedule(
            //@UserId Long id,
            @PathVariable("yyyy") Integer year,
            @PathVariable("MM") Integer month,
            @PathVariable("dd") Integer date) {

        LocalDate specificDate = LocalDate.of(year, month, date);
        System.out.println(specificDate);
        return doseService.getDayDoseSchedule(1L,specificDate);
    }

    @GetMapping("/percent/{yyyy}/{MM}/{dd}")
    @Operation(summary = "복용 퍼센트 하루 가져오기", description = "환자가 지정한 날짜에 복용한 약 퍼센트를 가져온다.")
    public ResponseDto<PercentDto> getOneDayDosePercent(
            //@UserId Long id,
            @PathVariable("yyyy") Integer year,
            @PathVariable("MM") Integer month,
            @PathVariable("dd") Integer date) {

        LocalDate specificDate = LocalDate.of(year, month, date);
        return doseService.getDayDosePercent(1L,specificDate);
    }

    @GetMapping("/percent/{yyyy}/{MM}/{dd}/week")
    @Operation(summary = "복용 퍼센트 일주일 치 가져오기 ", description = "환자가 지정한 날짜에 복용한 약 퍼센트를 일주일 치 가져온다.")
    public ResponseDto<List<PercentDto>> getWeekDosePercent(
            //@UserId Long id,
            @PathVariable("yyyy") Integer year,
            @PathVariable("MM") Integer month,
            @PathVariable("dd") Integer date) {

        LocalDate specificDate = LocalDate.of(year, month, date);
        return doseService.getDayWeekPercent(1L,specificDate);
    }

    @GetMapping("/percent/{yyyy}/{MM}/{dd}/month")
    @Operation(summary = "복용 퍼센트 한달 치 가져오기 ", description = "환자가 지정한 날짜에 복용한 약 퍼센트를 한달 치 가져온다.")
    public ResponseDto<List<PercentDto>> getMonthDosePercent(
            //@UserId Long id,
            @PathVariable("yyyy") Integer year,
            @PathVariable("MM") Integer month,
            @PathVariable("dd") Integer date) {

        LocalDate specificDate = LocalDate.of(year, month, date);
        return doseService.getDayMonthPercent(1L,specificDate);
    }

    @PutMapping("/{yyyy}/{MM}/{dd}/{dosingTime}")
    @Operation(summary = "시간대마다 모두완료(복용) 업데이트",description = "아침시간대에 5개의 약이 존재할 때 모두완료를 눌러 약의 복용여부를 전부 True로 바꾼다")
    public ResponseDto<Boolean> updateDoseTakeByTime(
            //@UserId Long id,
            @PathVariable("yyyy") Integer year,
            @PathVariable("MM") Integer month,
            @PathVariable("dd") Integer date,
            @PathVariable EDosingTime dosingTime){

        LocalDate specificDate = LocalDate.of(year, month, date);
        return doseService.updateDoseTakeByTime(1L,specificDate,dosingTime);
    }

    @PutMapping("/{yyyy}/{MM}/{dd}/{dosingTime}/{pillName}")
    @Operation(summary = "시간대마다 모두완료(복용) 업데이트",description = "아침시간대에 5개의 약이 존재할 때 모두완료를 눌러 약의 복용여부를 전부 True로 바꾼다")
    public ResponseDto<Boolean> updateDoseTakeByPill(
            //@UserId Long id,
            @PathVariable("yyyy") Integer year,
            @PathVariable("MM") Integer month,
            @PathVariable("dd") Integer date,
            @PathVariable EDosingTime dosingTime,
            @PathVariable String pillName){

        LocalDate specificDate = LocalDate.of(year, month, date);
        return doseService.updateDoseTakeByTimeAndPillName(1L,specificDate,dosingTime,pillName);
    }



}
