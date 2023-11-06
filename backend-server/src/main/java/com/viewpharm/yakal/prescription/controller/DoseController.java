package com.viewpharm.yakal.prescription.controller;

import com.viewpharm.yakal.base.dto.ResponseDto;
import com.viewpharm.yakal.base.annotation.Date;
import com.viewpharm.yakal.base.annotation.Enum;
import com.viewpharm.yakal.base.annotation.UserId;
import com.viewpharm.yakal.prescription.dto.request.CreateScheduleDto;
import com.viewpharm.yakal.user.dto.request.UpdateIsTakenDto;
import com.viewpharm.yakal.prescription.service.DoseService;
import com.viewpharm.yakal.base.type.EDosingTime;
import com.viewpharm.yakal.prescription.dto.response.DoseCodesDto;
import com.viewpharm.yakal.prescription.dto.response.OneDayScheduleDto;
import com.viewpharm.yakal.prescription.dto.response.OneDaySummaryDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;

import org.hibernate.validator.constraints.Range;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Nullable;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/doses")
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

    @GetMapping("/between")
    @Operation(summary = "날짜 사이의 복용 달성도 가져오기", description = "두개의 날짜 사이의 약 복용 달성도를 하루 단위로 가져온다.")
    public ResponseDto<List<OneDaySummaryDto>> getMonthDosePercent(
            @UserId Long id,
            @RequestParam @Valid @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
            @RequestParam @Valid @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate
    ) {
        final List<OneDaySummaryDto> oneMonthSummary = doseService.getBetweenDaySummary(id, startDate, endDate);
        return ResponseDto.ok(oneMonthSummary);
    }

    @PatchMapping("/count")
    @Operation(summary = "약 개수 변경", description = "특정 시간대의 특정 약의 개수를 ID로 특정하여 변경합니다.")
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
        doseService.updateIsTakenById(doesId, updateIsTakenDto.getIsTaken(), updateIsTakenDto.getDosingTime());
        return ResponseDto.ok(null);
    }

    @PostMapping("")
    @Operation(summary = "복용 스케쥴 추가", description = "특정 약에 대한 복용 스케줄을 추가합니다.")
    public ResponseDto<List<Boolean>> createSchedule(
            @UserId Long id,
            @Valid @RequestBody CreateScheduleDto createScheduleDto,
            @RequestParam @Nullable String inputName
    ) {
        final List<Boolean> isInserted = doseService.createSchedule(id, createScheduleDto, inputName);
        return ResponseDto.created(isInserted);
    }

    @DeleteMapping("")
    @Operation(summary = "선택된 약 스케줄 삭제", description = "약 스케줄 ID를 받아 그에 해당하는 스케줄을 삭제합니다.")
    public ResponseDto<Object> deleteScheduleByIds(
            @UserId Long id,
            @RequestBody List<Long> doesIdList
    ) {
        doseService.deleteSchedule(doesIdList);
        return ResponseDto.ok(null);
    }

    @Deprecated
    @GetMapping("/name")
    @Operation(summary = "약 이름으로 kdCode와 atcCode 가져오기")
    public ResponseDto<DoseCodesDto> getKDCodeAndATCCode(@RequestParam String dosename) {
        return ResponseDto.ok(doseService.getKDCodeAndATCCode(dosename));
    }
}
