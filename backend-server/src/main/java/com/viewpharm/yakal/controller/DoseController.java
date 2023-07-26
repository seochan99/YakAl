package com.viewpharm.yakal.controller;


import com.viewpharm.yakal.annotation.Date;
import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.DoesRequestDto;
import com.viewpharm.yakal.dto.DoseDto;
import com.viewpharm.yakal.dto.PercentDto;
import com.viewpharm.yakal.dto.ResponseDto;
import com.viewpharm.yakal.service.DoseService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/dose")
@Tag(name = "Dose", description = "환자의 복용 정보 추가, 열람, 수정, 삭제")
public class DoseController {

    private final DoseService doseService;

    @GetMapping("/schedule/day")
    @Operation(summary = "하루 복용 스케줄 가져오기", description = "지정된 날짜에 복용해야 하는 약 목록을 가져온다.")
    public ResponseDto<DoseDto> getOneDayDoseSchedule(
            @UserId Long id,
            @RequestParam("date") @Valid @Date @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date) {
        return doseService.getDayDoseSchedule(id, date);
    }

    @GetMapping("/progress/day")
    @Operation(summary = "하루 복용 달성도 가져오기", description = "환자가 지정한 날짜의 약 복용 달성도를 가져온다.")
    public ResponseDto<PercentDto> getOneDayDosePercent(
            @UserId Long id,
            @RequestParam("date") @Valid @Date @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date) {
        return doseService.getDayDosePercent(id, date);
    }

    @GetMapping("/progress/week")
    @Operation(summary = "일주일 복용 달성도 가져오기", description = "환자가 지정한 날짜가 포함된 일주일동안의 약 복용 달성도를 하루 단위로 가져온다.")
    public ResponseDto<List<PercentDto>> getWeekDosePercent(
            @UserId Long id,
            @RequestParam("date") @Valid @Date @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date) {
        return doseService.getDayWeekPercent(id, date);
    }

    @GetMapping("/progress/month")
    @Operation(summary = "한 달 복용 달성도 가져오기 ", description = "환자가 지정한 달의 약 복용 달성도를 하루 단위로 가져온다.")
    public ResponseDto<List<PercentDto>> getMonthDosePercent(
            @UserId Long id,
            @RequestParam("year-month") @Valid @DateTimeFormat(pattern = "yyyy-MM") YearMonth yearMonth) {
        return doseService.getDayMonthPercent(id, yearMonth);
    }

    @PatchMapping("/cnt")
    @Operation(summary = "약의 개수 변경",description = "doesIdList로 여러개의 약의 개수를 +1")
    public ResponseDto<Boolean> updateDoseCnt(
            @UserId Long id,
            @RequestBody List<Long> doesIdList){
        return doseService.updateDoseCnt(id, doesIdList);
    }

    @PatchMapping("/cnt/{doesId}")
    @Operation(summary = "약의 개수 변경",description = "doesId로 특정 약의 개수를 +1")
    public ResponseDto<Boolean> updateDoseCntByDoesId(
            //@UserId Long id,
            @PathVariable Long doesId){

        return doseService.updateDoseCntById(1L,doesId);
    }

    @PatchMapping("/take")
    @Operation(summary = "시간대마다 모두완료(복용) 업데이트",description = "아침시간대에 5개의 약이 존재할 때 모두완료를 눌러 약의 복용여부를 전부 True로 바꾼다")
    public ResponseDto<Boolean> updateDoseTakeByTime(
            //@UserId Long id,
            @RequestBody DoesRequestDto doesRequestDto){

        return doseService.updateDoseTakeByTime(1L,doesRequestDto.getDate(),doesRequestDto.getTime());
    }

    @PatchMapping("/take/{doseId}")
    @Operation(summary = "복용 업데이트",description = "특정 시간대의 약의 복용 여부를 True로 바꾼다")
    public ResponseDto<Boolean> updateDoseTakeByPill(
            //@UserId Long id,
            @PathVariable Long doseId){

        return doseService.updateDoseTakeById(1L,doseId);
    }

    @PostMapping("/schedule")
    @Operation(summary = "스케쥴 추가",description = "직접 한가지의 약을 추가한다 0이 반환되면 정상 추가 아니라면 이미 존재하는 약의 Id 와 false 반환")
    public ResponseDto<Long> createSchedule(
            //@UserId Long id,
            @RequestBody DoesRequestDto doesRequestDto){

        return doseService.createSchedule(1L,doesRequestDto);
    }

    @PostMapping("/schedules")
    @Operation(summary = "스케쥴 추가",description = "여러가지 약을 추가한다 중복된 약 있을 경우 false이며 List안에 약 Id존재")
    public ResponseDto<List<Long>> createSchedules(
            //@UserId Long id,
            @RequestBody List<DoesRequestDto> doesRequestDtoList){

        return doseService.createSchedules(1L,doesRequestDtoList);
    }

    @DeleteMapping("/schedule/{doseId}")
    @Operation(summary = "약 스케쥴 하나 삭제",description = "약 Id로 개별 약 삭제")
    public ResponseDto<Boolean> deleteSchedule(
            //@UserId
            @PathVariable Long doseId
    ){

        return doseService.deleteSchedule(1L,doseId);
    }

    @DeleteMapping("/schedule")
    @Operation(summary = "약 스케쥴 하나 삭제",description = "약 Id로 개별 약 삭제")
    public ResponseDto<Boolean> deleteSchedule(
            //@UserId
            @PathVariable Long doseId,
            @RequestBody List<Long> doesIdList
    ){
        return doseService.deleteSchedules(1L,doesIdList);
    }



}
