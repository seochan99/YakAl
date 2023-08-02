package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Dose;

import com.viewpharm.yakal.domain.MobileUser;
import com.viewpharm.yakal.domain.Prescription;
import com.viewpharm.yakal.domain.Risk;
import com.viewpharm.yakal.dto.request.CreateScheduleDto;
import com.viewpharm.yakal.dto.request.OneMedicineScheduleDto;
import com.viewpharm.yakal.dto.request.OneScheduleDto;
import com.viewpharm.yakal.dto.response.*;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.DoseRepository;
import com.viewpharm.yakal.repository.PrescriptionRepository;
import com.viewpharm.yakal.repository.MobileUserRepository;
import com.viewpharm.yakal.repository.RiskRepository;
import com.viewpharm.yakal.type.EDosingTime;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.*;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class DoseService {

    private final MobileUserRepository mobileUserRepository;
    private final DoseRepository doseRepository;
    private final PrescriptionRepository prescriptionRepository;
    private final RiskRepository riskRepository;
    public <T> Map<EDosingTime, List<T>> createMap() {
        Map<EDosingTime, List<T>> map = new HashMap<>(EDosingTime.values().length);
        map.put(EDosingTime.MORNING, new ArrayList<>());
        map.put(EDosingTime.AFTERNOON, new ArrayList<>());
        map.put(EDosingTime.EVENING, new ArrayList<>());
        map.put(EDosingTime.DEFAULT, new ArrayList<>());
        return map;
    }

    public OneDayScheduleDto getOneDaySchedule(final Long userId, final LocalDate date) {
        final List<Dose> getDoses = doseRepository.findByUserIdAndDate(userId, date);

        final Map<EDosingTime, List<OneTimeScheduleDto>> scheduleMap = createMap();

        List<DoseRepository.overlapDetail> overlapList = doseRepository.findOverlapDetail(userId, date);

        final Map<EDosingTime, List<OverlapDto>> overlapMap = createMap();


        for (DoseRepository.overlapDetail overlapDetail : overlapList){
            final OverlapDto overlapDto = OverlapDto.builder()
                    .ATCCode(overlapDetail.getATCCode())
                    .KDCodes(overlapDetail.getKDCodes())
                    .build();
            overlapMap.get(overlapDetail.getTime()).add(overlapDto);
        }

        for (final Dose result : getDoses) {

            final OneTimeScheduleDto oneTimeScheduleDto = OneTimeScheduleDto.builder()
                    .id(result.getId())
                    .KDCode(result.getKDCode())
                    .ATCCode(result.getATCCode())
                    .isTaken(result.getIsTaken())
                    .isOverlap(overlapMap.containsKey(result.getATCCode().getId()))
                    .count(result.getPillCnt() + (result.getIsHalf() ? 0.5 : 0))
                    .prescriptionId(result.getPrescription().getId())
                    .build();
            scheduleMap.get(result.getTime()).add(oneTimeScheduleDto);
        }

        final OneDayScheduleDto oneDayScheduleDto = new OneDayScheduleDto(date,scheduleMap,overlapMap);

        return oneDayScheduleDto;
    }

    public Long getOneDayProgressOrNull(final Long userId, final LocalDate date) {
        final DoseRepository.oneDaySummary totalAndPortion = doseRepository.countTotalAndTakenByUserIdAndDate(userId, date);

        if (totalAndPortion.getTotal() == 0) {
            return null;
        }

        return Math.round(totalAndPortion.getTake() / (double) totalAndPortion.getTotal() * 100.0);
    }

    public Map<DayOfWeek, OneDaySummaryDto> getOneWeekSummary(final Long userId, final LocalDate date){
        final int ONE_WEEK_DAYS = DayOfWeek.values().length;

        final LocalDate startOfWeek = date.minusDays(date.getDayOfWeek().getValue() % ONE_WEEK_DAYS);
        final LocalDate endOfWeek = startOfWeek.plusDays(ONE_WEEK_DAYS - 1);

        final List<DoseRepository.oneDaySummary> totalAndPortionList
                = doseRepository.countTotalAndTakenByUserIdInPeriod(userId, startOfWeek, endOfWeek);
        final List<DoseRepository.overlap> overlapList
                = doseRepository.findOverlap(userId,startOfWeek,endOfWeek);

        final Map<DayOfWeek, OneDaySummaryDto> oneWeekSummary = new HashMap<>(ONE_WEEK_DAYS);

        // 일주일 각 날짜에 대한 처리
        for (int i = 0; i < ONE_WEEK_DAYS; ++i) {
            Long progressOrNull = null; // 초기값을 null로 설정
            LocalDate currentDate = startOfWeek.plusDays(i); // 현재 날짜 계산
            Boolean isOverlapped = false;


            for (DoseRepository.oneDaySummary summary : totalAndPortionList) {
                //성분 중복 검사
                for (DoseRepository.overlap overlap : overlapList
                ) {
                    if (overlap.getDate().equals(currentDate)){
                        isOverlapped = true;
                        break;
                    }
                }

                // 결과 리스트에서 현재 날짜와 일치하는 데이터 찾기
                if (summary.getDate().equals(currentDate)) {
                    Long total = summary.getTotal();
                    Long portion = summary.getTake();
                    // progressOrNull 계산 (null인 경우 예외 처리)
                    progressOrNull = (total == null || total == 0) ? null : Math.round(portion / (double) total * 100.0);
                    break;
                }
            }

            // OneDaySummaryDto 객체 생성 및 결과 맵에 추가
            final OneDaySummaryDto oneDaySummaryDto = new OneDaySummaryDto(currentDate, progressOrNull, isOverlapped);
            oneWeekSummary.put(DayOfWeek.values()[(i + ONE_WEEK_DAYS - 1) % ONE_WEEK_DAYS], oneDaySummaryDto);
        }

        return oneWeekSummary;
    }



    public Map<LocalDate, OneDaySummaryWithoutDateDto> getOneMonthSummary(final Long userId, final YearMonth yearMonth) {
        final int ONE_MONTH_DAYS = yearMonth.lengthOfMonth();

        final LocalDate startOfMonth = yearMonth.atDay(1);
        final LocalDate endOfMonth = yearMonth.atEndOfMonth();

        final List<DoseRepository.oneDaySummary> totalAndPortionList
                = doseRepository.countTotalAndTakenByUserIdInPeriod(userId, startOfMonth, endOfMonth);
        final List<DoseRepository.overlap> overlapList
                = doseRepository.findOverlap(userId,startOfMonth,endOfMonth);

        final Map<LocalDate, OneDaySummaryWithoutDateDto> oneMonthSummary = new HashMap<>(ONE_MONTH_DAYS);

        for (int i = 0; i < ONE_MONTH_DAYS; ++i) {
            Long progressOrNull = null; // 초기값을 null로 설정
            LocalDate currentDate = startOfMonth.plusDays(i); // 현재 날짜 계산
            Boolean isOverlapped = false;

            // 결과 리스트에서 현재 날짜와 일치하는 데이터 찾기
            for (DoseRepository.oneDaySummary summary : totalAndPortionList) {
                //성분 중복 검사
                for (DoseRepository.overlap overlap : overlapList
                ) {
                    if (overlap.getDate().equals(currentDate)){
                        isOverlapped = true;
                        break;
                    }
                }

                if (summary.getDate().equals(startOfMonth.plusDays(i))) {
                    Long total = summary.getTotal();
                    Long portion = summary.getTake();
                    // progressOrNull 계산 (null인 경우 예외 처리)
                    progressOrNull = (total == null || total == 0) ? null : Math.round(portion / (double) total * 100.0);
                    break;
                }
            }

            final OneDaySummaryWithoutDateDto oneDaySummaryWithoutDateDto = new OneDaySummaryWithoutDateDto(progressOrNull, isOverlapped);
            oneMonthSummary.put(startOfMonth.plusDays(i), oneDaySummaryWithoutDateDto);
        }

        return oneMonthSummary;
    }

    public Map<String, Boolean> updateDoseCount(final Map<Long, Double> updateDoseCountDto) {
        final Map<String, Boolean> isUpdatedMap = new HashMap<>(updateDoseCountDto.size());

        for (final Long doseId : updateDoseCountDto.keySet()) {
            final Double count = updateDoseCountDto.get(doseId);
            final Integer isUpdated = doseRepository.updateCountById(doseId, count.longValue(), count.toString().endsWith(".5"));

            isUpdatedMap.put(doseId.toString(), isUpdated == 1);
        }

        return isUpdatedMap;
    }

    public void updateIsTakenByTime(final Long userId, final LocalDate date, final EDosingTime time, final Boolean isTaken) {
        List<Dose> doses = doseRepository.findByUserIdAndDateAndTime(userId, date, time);
        for (Dose dose : doses
             ) {
            dose.updateIsTaken(isTaken);
        }
    }

    public void updateIsTakenById(final Long doseId, final Boolean isTaken){
        Dose dose = doseRepository.findById(doseId).orElseThrow(()-> new CommonException(ErrorCode.NOT_FOUND_DOSE));
        dose.updateIsTaken(isTaken);
    }

    public List<Boolean> createSchedule(final Long userId, final CreateScheduleDto createScheduleDto) {
        final MobileUser mobileUser = mobileUserRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        final Prescription prescription = prescriptionRepository.findById(createScheduleDto.getPrescriptionId())
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_PRESCRIPTION));

        final List<Boolean> isInserted = new ArrayList<>();
        final List<Dose> willSave = new ArrayList<>();

        for (final OneMedicineScheduleDto oneMedicineScheduleDto : createScheduleDto.getMedicines()) {
            final String KDCode = oneMedicineScheduleDto.getKDCode();
            final String ATCCode = oneMedicineScheduleDto.getATCCode();

            for (final OneScheduleDto oneScheduleDto : oneMedicineScheduleDto.getSchedules()) {

                final Boolean isOverlapped = doseRepository.existsByMobileUserIdAndKDCodeAndDateAndTime(
                        userId, KDCode, oneScheduleDto.getDate(), oneScheduleDto.getTime()
                );

                isInserted.add(!isOverlapped);

                if (!isOverlapped) {
                    Risk risk = riskRepository.findById(ATCCode).orElseThrow(()->new CommonException(ErrorCode.NOT_FOUND_RISK));
                    final Dose dose = Dose.builder()
                            .kdCode(KDCode)
                            .ATCCode(risk)
                            .date(oneScheduleDto.getDate())
                            .time(oneScheduleDto.getTime())
                            .pillCnt(oneScheduleDto.getCount().longValue())
                            .isHalf(oneScheduleDto.getCount().toString().endsWith(".5"))
                            .prescription(prescription)
                            .mobileUser(mobileUser)
                            .build();

                    willSave.add(dose);
                }

            }
        }

        doseRepository.saveAll(willSave);

        return isInserted;
    }

    public void deleteSchedule(final List<Long> ids){
        doseRepository.deleteAllByIdInBatch(ids);
    }
}
