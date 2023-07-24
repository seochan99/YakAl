package com.viewpharm.yakal.controller;


import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.DoesRequestDto;
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
    @GetMapping("/schedule")
    @Operation(summary = "복용 스케줄 가져오기", description = "환자가 지정한 날짜에 복용해야 하는 약 목록을 가져온다.")
    public ResponseDto<DoseDto> getOneDayDoseSchedule(
            //@UserId Long id,
            @RequestBody DoesRequestDto doesRequestDto) {

        return doseService.getDayDoseSchedule(1L,doesRequestDto.getDate());
    }

    @GetMapping("/percent")
    @Operation(summary = "복용 퍼센트 하루 가져오기", description = "환자가 지정한 날짜에 복용한 약 퍼센트를 가져온다.")
    public ResponseDto<PercentDto> getOneDayDosePercent(
            //@UserId Long id,
            @RequestBody DoesRequestDto doesRequestDto) {
        return doseService.getDayDosePercent(1L,doesRequestDto.getDate());
    }

    @GetMapping("/percent/week")
    @Operation(summary = "복용 퍼센트 일주일 치 가져오기 ", description = "환자가 지정한 날짜에 복용한 약 퍼센트를 일주일 치 가져온다.")
    public ResponseDto<List<PercentDto>> getWeekDosePercent(
            //@UserId Long id,
            @RequestBody DoesRequestDto doesRequestDto) {

        return doseService.getDayWeekPercent(1L,doesRequestDto.getDate());
    }

    @GetMapping("/percent/month")
    @Operation(summary = "복용 퍼센트 한달 치 가져오기 ", description = "환자가 지정한 날짜에 복용한 약 퍼센트를 한달 치 가져온다.")
    public ResponseDto<List<PercentDto>> getMonthDosePercent(
            //@UserId Long id,
            @RequestBody DoesRequestDto doesRequestDto) {

        return doseService.getDayMonthPercent(1L,doesRequestDto.getDate());
    }

    @PutMapping("/cnt")
    @Operation(summary = "약의 개수 변경",description = "doesIdList로 여러개의 약의 개수를 +1")
    public ResponseDto<Boolean> updateDoseCnt(
            //@UserId Long id,
            @RequestBody List<Long> doesIdList){

        return doseService.updateDoseCnt(1L,doesIdList);
    }

    @PutMapping("/cnt/{doesId}")
    @Operation(summary = "약의 개수 변경",description = "doesId로 특정 약의 개수를 +1")
    public ResponseDto<Boolean> updateDoseCntByDoesId(
            //@UserId Long id,
            @PathVariable Long doesId){

        return doseService.updateDoseCntById(1L,doesId);
    }

    @PutMapping("/take")
    @Operation(summary = "시간대마다 모두완료(복용) 업데이트",description = "아침시간대에 5개의 약이 존재할 때 모두완료를 눌러 약의 복용여부를 전부 True로 바꾼다")
    public ResponseDto<Boolean> updateDoseTakeByTime(
            //@UserId Long id,
            @RequestBody DoesRequestDto doesRequestDto){

        return doseService.updateDoseTakeByTime(1L,doesRequestDto.getDate(),doesRequestDto.getTime());
    }

    @PutMapping("/take/{doseId}")
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
