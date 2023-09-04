package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.Date;
import com.viewpharm.yakal.domain.Medical;
import com.viewpharm.yakal.domain.Notification;
import com.viewpharm.yakal.dto.response.LoginLogListDto;
import com.viewpharm.yakal.dto.response.LoginLogListForMonthDto;
import com.viewpharm.yakal.dto.response.NotificationPerHourListDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.service.LoginLogService;
import com.viewpharm.yakal.service.MedicalService;
import com.viewpharm.yakal.service.NotificationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
<<<<<<< HEAD
import org.apache.xpath.operations.Bool;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.YearMonth;
=======
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
>>>>>>> c6916a5afd9a63c95994eafe8e382a6d2753ba96
import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/admin")
@Tag(name = "Admin", description = "관리자 전용 페이지 관련 API 제공")
public class AdminController {

    private final MedicalService medicalService;
    private final LoginLogService loginLogService;
    private final NotificationService notificationService;

    @GetMapping("/medical/update")
    @Operation(summary = "의료기관 업데이트", description = "의료기관 엑셀파일을 입력으로 의료기관의 정보를 업데이트 합니다. (공공데이터 포털 3개월마다 업데이트)")
    public ResponseDto<Boolean> updateMedical() throws IOException {
        return ResponseDto.ok(medicalService.updateMedical());
    }

    @GetMapping("/medical/{name}")
    @Operation(summary = "의료기관 가져오기", description = "의료기관 이름으로 가져온다")
    public ResponseDto<List<MedicalDto>> getMedical(@PathVariable String name) throws UnsupportedEncodingException {
        String decodeVal = URLDecoder.decode(name, "utf-8");
        return ResponseDto.ok(medicalService.getByName(decodeVal));
    }

    @GetMapping("/medical/register")
    @Operation(summary = "의료기관 가져오기", description = "등록된 의료기관을 가져온다")
    public ResponseDto<List<MedicalDto>> getMedical() {
        return ResponseDto.ok(medicalService.getAllByRegister());
    }

    @PatchMapping("medical/register/{id}")
    @Operation(summary = "의료기관 등록", description = "의료기관을 약알에 등록 혹은 해제")
    public ResponseDto<Boolean> registerMedical(@PathVariable Long id) {
        return ResponseDto.ok(medicalService.updateMedicalRegister(id));
    }

    @GetMapping("/loginLog/day/week/{date}")
    @Operation(summary = "사용자 통계 가져오기", description = "하루 단위로 일주일 치 가져오기")
    public ResponseDto<List<LoginLogListDto>> getLoginLogForWeek(@PathVariable("date") @Valid @Date @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date) {
        return ResponseDto.ok(loginLogService.getUserOneDayForWeek(date));
    }

    @GetMapping("/loginLog/day/month/{month}")
    @Operation(summary = "사용자 통계 가져오기", description = "하루 단위로 한달 치 가져오기")
    public ResponseDto<List<LoginLogListDto>> getLoginLogForMonth(@PathVariable("month") @Valid @com.viewpharm.yakal.annotation.YearMonth @DateTimeFormat(pattern = "yyyy-MM") YearMonth yearMonth
    ) {
        return ResponseDto.ok(loginLogService.getUserOneDayForMonth(yearMonth));
    }

    @GetMapping("/loginLog/month/{month}")
    @Operation(summary = "사용자 통계 가져오기", description = "한달 단위로 6개월 치 가져오기")
    public ResponseDto<List<LoginLogListForMonthDto>> getLoginLogForSixMonth(@PathVariable("month") @Valid @com.viewpharm.yakal.annotation.YearMonth @DateTimeFormat(pattern = "yyyy-MM") YearMonth yearMonth
    ) {
        return ResponseDto.ok(loginLogService.getUserOneMonthForSixMonth(yearMonth));
    }

    @GetMapping("/loginLog/year/{month}")
    @Operation(summary = "사용자 통계 가져오기", description = "한달 단위로 일년 치 가져오기")
    public ResponseDto<List<LoginLogListForMonthDto>> getLoginLogForYear(@PathVariable("month") @Valid @com.viewpharm.yakal.annotation.YearMonth @DateTimeFormat(pattern = "yyyy-MM") YearMonth yearMonth
    ) {
        return ResponseDto.ok(loginLogService.getUserOneMonthForYear(yearMonth));
    }

    @GetMapping("/notification/{date}")
    @Operation(summary = "알림 통계 가져오기", description = "받은 날짜 한시간 단위로 통계 가져오기")
    public ResponseDto<List<NotificationPerHourListDto>> getNotificationNumberPerHour(@PathVariable("date") @Valid @Date @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date) {
        return ResponseDto.ok(notificationService.getNotificationNumberPerHour(date));
    }
}
