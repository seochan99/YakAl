package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.Date;
import com.viewpharm.yakal.dto.request.UpdateAdminRequestDto;
import com.viewpharm.yakal.dto.response.*;
import com.viewpharm.yakal.service.*;
import com.viewpharm.yakal.type.EMedical;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Nullable;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.YearMonth;
import lombok.extern.slf4j.Slf4j;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
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
    private final RegistrationService registrationService;

    private final UserService userService;
    private final ExpertService expertService;

    @GetMapping("/medical/update")
    @Operation(summary = "의료기관 업데이트", description = "의료기관 엑셀파일을 입력으로 의료기관의 정보를 업데이트 합니다. (공공데이터 포털 3개월마다 업데이트)")
    public ResponseDto<Boolean> updateMedical() throws IOException {
        return ResponseDto.ok(medicalService.updateMedical());
    }

    @GetMapping("/medical/search")
    @Operation(summary = "의료기관 가져오기", description = "의료기관 이름으로 가져온다")
    public ResponseDto<List<MedicalDto>> getMedicalByName(@RequestParam String name) {
        return ResponseDto.ok(medicalService.getByName(name));
    }
    @GetMapping("/medical/register/hospital")
    @Operation(summary = "병원 가져오기", description = "등록된 병원을 가져온다")
    public ResponseDto<List<MedicalDto>> getRegisterHospital(
            @RequestParam("page") Long page, @RequestParam("num") Long num
            ,@RequestParam("name") @Nullable String name
    ) {
        return ResponseDto.ok(medicalService.getAllByRegister(page,num, EMedical.HOSPITAL, name));
    }

    @GetMapping("/medical/register/pharmacy")
    @Operation(summary = "병원 가져오기", description = "등록된 병원을 가져온다")
    public ResponseDto<List<MedicalDto>> getRegisterPharmacy(
            @RequestParam("page") Long page, @RequestParam("num") Long num
            ,@RequestParam("name") @Nullable String name
    ) {
        return ResponseDto.ok(medicalService.getAllByRegister(page,num, EMedical.PHARMACY, name));
    }

    @GetMapping("medical/register/request")
    @Operation(summary = "의료기관 등록 신청",description = "관리자가 의료기관 등록 신청한 목록 가져온다")
    public ResponseDto<List<MedicalRegisterDto>> getMedicalRegisterReqeust(
            @RequestParam("page") Long page, @RequestParam("num") Long num
    ){
        return ResponseDto.ok(registrationService.getMedicalRegisterList(page,num));
    }

    @GetMapping("expert/register/request")
    @Operation(summary = "전문가 등록 신청",description = "관리자가 전문가 등록 신청한 목록 가져온다")
    public ResponseDto<List<ExpertRegisterDto>> getExpertRegisterReqeust(
            @RequestParam("page") Long page, @RequestParam("num") Long num
    ){
        return ResponseDto.ok(expertService.getExpertRegisterList(page, num));
    }

    @PatchMapping("medical/register/{id}")
    @Operation(summary = "의료기관 등록", description = "의료기관을 약알에 등록 혹은 반려")
    public ResponseDto<Boolean> registerMedical(@PathVariable Long id, @RequestBody UpdateAdminRequestDto updateAdminRequestDto){
        return ResponseDto.ok(medicalService.updateRegister(id,updateAdminRequestDto));
    }

    @PatchMapping("expert/register/{id}")
    @Operation(summary = "전문가 등록", description = "전문가로 약알에 등록 혹은 반려")
    public ResponseDto<Boolean> certifyExpert(@PathVariable Long id, @RequestBody UpdateAdminRequestDto updateAdminRequestDto){
        userService.updateIsCertified(id,updateAdminRequestDto);
        return ResponseDto.ok(null);
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
