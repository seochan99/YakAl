package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.Date;
import com.viewpharm.yakal.annotation.Enum;
import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.request.CreateScheduleDto;
import com.viewpharm.yakal.dto.response.OneDaySummaryDto;
import com.viewpharm.yakal.dto.response.OneDayScheduleDto;
import com.viewpharm.yakal.dto.response.OneDayProgressDto;
import com.viewpharm.yakal.dto.response.OneDaySummaryWithoutDateDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.dto.request.UpdateIsTakenDto;
import com.viewpharm.yakal.service.DoseService;
import com.viewpharm.yakal.type.EDosingTime;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;

import org.hibernate.validator.constraints.Range;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/dose")
@Tag(name = "Dose", description = "환자의 복용 정보 추가, 열람, 수정, 삭제")
public class DoseController {

    private final DoseService doseService;

    @GetMapping("/day/{date}")
    @Operation(summary = "하루 복용 스케줄 가져오기", description = "지정된 날짜에 복용해야 하는 약 목록을 가져온다.")
    public ResponseDto<OneDayScheduleDto> getOneDayDoseSchedule(
            @UserId Long id,
            @PathVariable("date") @Valid @Date @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date
    ) {
        final OneDayScheduleDto oneDayScheduleDto = doseService.getOneDaySchedule(id, date);
        return ResponseDto.ok(oneDayScheduleDto);
    }

    @GetMapping("/day/progress/{date}")
    @Operation(summary = "하루 복용 달성도 가져오기", description = "환자가 지정한 날짜의 약 복용 달성도를 가져온다.")
    public ResponseDto<OneDayProgressDto> getOneDayDoseProgress(
            @UserId Long id,
            @PathVariable("date") @Valid @Date @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date
    ) {
        final Long progressOrNull = doseService.getOneDayProgressOrNull(id, date);
        final OneDayProgressDto oneDayProgressDto = new OneDayProgressDto(date, progressOrNull);
        return ResponseDto.ok(oneDayProgressDto);
    }


    @GetMapping("/week/{date}")
    @Operation(summary = "일주일 복용 달성도와 성분 중복 여부 가져오기", description = "환자가 지정한 날짜가 포함된 일주일동안의 약 복용 달성도를 하루 단위로 가져온다.")
    public ResponseDto<Map<DayOfWeek, OneDaySummaryDto>> getOneWeekDose(
            @UserId Long id,
            @PathVariable("date") @Valid @Date @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date
    ) {
        final Map<DayOfWeek, OneDaySummaryDto> oneDaySummary = doseService.getOneWeekSummary(id, date);
        return ResponseDto.ok(oneDaySummary);
    }

    @GetMapping("/month/{month}")
    @Operation(summary = "한 달 복용 달성도 가져오기", description = "환자가 지정한 달의 약 복용 달성도를 하루 단위로 가져온다.")
    public ResponseDto<Map<LocalDate, OneDaySummaryWithoutDateDto>> getMonthDosePercent(
            @UserId Long id,
            @PathVariable("month") @Valid @com.viewpharm.yakal.annotation.YearMonth @DateTimeFormat(pattern = "yyyy-MM") YearMonth yearMonth
    ) {
        final Map<LocalDate, OneDaySummaryWithoutDateDto> oneMonthSummary = doseService.getOneMonthSummary(id, yearMonth);
        return ResponseDto.ok(oneMonthSummary);
    }

    @PatchMapping("/count")
    @Operation(summary = "약 개수 변경",description = "특정 시간대의 특정 약의 개수를 ID로 특정하여 변경합니다.")
    public ResponseDto<Map<String, Boolean>> updateDoseCount(
            @UserId Long id,
            @RequestBody Map<@NotNull @Range(min = 1L) Long, @NotNull @DecimalMin("0.5") Double> updateDoseCountDto
    ) {
        final Map<String, Boolean> isUpdatedMap = doseService.updateDoseCount(updateDoseCountDto);
        return ResponseDto.ok(isUpdatedMap);
    }

    @PatchMapping("/taken/{date}/{time}")
    @Operation(summary = "특정 시간대의 스케줄 모두 복용 처리 혹은 취소", description = "특정 시간대의 복용 스케줄을 모두 완료 처리 혹은 취소합니다.")
    public ResponseDto<Boolean> updateIsTakenByTime(
            @UserId Long id,
            @PathVariable("date") @Valid @Date @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date,
            @PathVariable(value = "time") @Valid @Enum(enumClass = EDosingTime.class) EDosingTime dosingTime,
            @RequestBody @Valid UpdateIsTakenDto updateIsTakenDto
    ) {
        doseService.updateIsTakenByTime(id, date, dosingTime, updateIsTakenDto.getIsTaken());
        return ResponseDto.ok(null);
    }

    @PatchMapping("/taken/{id}")
    @Operation(summary = "특정 시간대의 특정 약 복용 처리 혹은 취소", description = "특정 시간대에서 ID로 특정된 복용 스케줄을 완료 처리 혹은 취소합니다.")
    public ResponseDto<Boolean> updateIsTakenById(
            @UserId Long id,
            @PathVariable("id") @Valid @Range(min = 1L) Long doesId,
            @RequestBody @Valid UpdateIsTakenDto updateIsTakenDto
    ) {
        doseService.updateIsTakenById(doesId, updateIsTakenDto.getIsTaken());
        return ResponseDto.ok(null);
    }

    @PostMapping("")
    @Operation(summary = "복용 스케쥴 추가",description = "특정 약에 대한 복용 스케줄을 추가합니다.")
    public ResponseDto<List<Boolean>> createSchedule(
            @UserId Long id,
            @RequestBody @Valid CreateScheduleDto createScheduleDto
    ) {
        final List<Boolean> isInserted = doseService.createSchedule(id, createScheduleDto);
        return ResponseDto.created(isInserted);
    }

    @DeleteMapping("")
    @Operation(summary = "선택된 약 스케줄 삭제",description = "약 스케줄 ID를 받아 그에 해당하는 스케줄을 삭제합니다.")
    public ResponseDto<Object> deleteScheduleByIds(
            @UserId Long id,
            @RequestBody List<Long> doesIdList
    ){
        doseService.deleteSchedule(doesIdList);
        return ResponseDto.ok(null);
    }
}
