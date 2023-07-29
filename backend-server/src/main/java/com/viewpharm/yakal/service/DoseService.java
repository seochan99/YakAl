package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Dose;

import com.viewpharm.yakal.domain.MobileUser;
import com.viewpharm.yakal.domain.Prescription;
import com.viewpharm.yakal.dto.request.CreateScheduleDto;
import com.viewpharm.yakal.dto.request.OneMedicineScheduleDto;
import com.viewpharm.yakal.dto.request.OneScheduleDto;
import com.viewpharm.yakal.dto.response.OneDayScheduleDto;
import com.viewpharm.yakal.dto.response.OneDaySummaryDto;
import com.viewpharm.yakal.dto.response.OneDaySummaryWithoutDateDto;
import com.viewpharm.yakal.dto.response.OneTimeScheduleDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.DoseRepository;
import com.viewpharm.yakal.repository.PrescriptionRepository;
import com.viewpharm.yakal.repository.MobileUserRepository;
import com.viewpharm.yakal.type.EDosingTime;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.Set;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class DoseService {

    private final Long OVERLAP_PERIOD = 30L;

    private final MobileUserRepository mobileUserRepository;
    private final DoseRepository doseRepository;
    private final PrescriptionRepository prescriptionRepository;

    public OneDayScheduleDto getOneDaySchedule(final Long userId, final LocalDate date) {
        final List<Dose> results = doseRepository.findByUserIdAndDate(userId, date);

        final Map<EDosingTime, List<OneTimeScheduleDto>> schedule = new HashMap<>(EDosingTime.values().length);
        schedule.put(EDosingTime.MORNING, new ArrayList<>());
        schedule.put(EDosingTime.AFTERNOON, new ArrayList<>());
        schedule.put(EDosingTime.EVENING, new ArrayList<>());
        schedule.put(EDosingTime.DEFAULT, new ArrayList<>());

        final OneDayScheduleDto oneDayScheduleDto = new OneDayScheduleDto(date, schedule);

        for (final Dose result : results) {
            final OneTimeScheduleDto oneTimeScheduleDto = OneTimeScheduleDto.builder()
                    .id(result.getId())
                    .pillName(result.getKDCode())
                    .isTaken(result.getIsTaken())
                    .count(result.getPillCnt() + (result.getIsHalf() ? 0.5 : 0))
                    .prescriptionId(result.getPrescription().getId())
                    .build();
            oneDayScheduleDto.getSchedule().get(result.getTime()).add(oneTimeScheduleDto);
        }

        return oneDayScheduleDto;
    }

    public Long getOneDayProgressOrNull(final Long userId, final LocalDate date) {
        final DoseRepository.TotalAndPortion totalAndPortion = doseRepository.countTotalAndTakenByUserIdAndDate(userId, date);

        if (totalAndPortion.getTotal() == 0) {
            return null;
        }

        return Math.round(totalAndPortion.getPortion() / (double) totalAndPortion.getTotal() * 100.0);
    }

    public Map<DayOfWeek, OneDaySummaryDto> getOneWeekSummary(final Long userId, final LocalDate date){
        final int ONE_WEEK_DAYS = DayOfWeek.values().length;

        final LocalDate startOfWeek = date.minusDays(date.getDayOfWeek().getValue() % ONE_WEEK_DAYS);
        final LocalDate endOfWeek = startOfWeek.plusDays(ONE_WEEK_DAYS - 1);

        final List<DoseRepository.TotalAndPortion> totalAndPortionList
                = doseRepository.countTotalAndTakenByUserIdInPeriod(userId, startOfWeek, endOfWeek);
        final Set<LocalDate> hasOverlappedDates = doseRepository.hasOverlappedIngredientByUserIdInPeriod(userId, startOfWeek, endOfWeek, OVERLAP_PERIOD);

        final Map<DayOfWeek, OneDaySummaryDto> oneWeekSummary = new HashMap<>(ONE_WEEK_DAYS);

        for (int i = 0; i < ONE_WEEK_DAYS; ++i) {
            final Long total = totalAndPortionList.get(i).getTotal();
            final Long portion = totalAndPortionList.get(i).getPortion();
            final Long progressOrNull = total == 0 ? null : Math.round(portion / (double) total * 100.0);
            final Boolean isOverlapped = hasOverlappedDates.contains(startOfWeek.plusDays(i));

            final OneDaySummaryDto oneDaySummaryDto = new OneDaySummaryDto(startOfWeek.plusDays(i), progressOrNull, isOverlapped);
            oneWeekSummary.put(DayOfWeek.values()[(i + ONE_WEEK_DAYS - 1) % ONE_WEEK_DAYS], oneDaySummaryDto);
        }

        return oneWeekSummary;
    }

    public Map<LocalDate, OneDaySummaryWithoutDateDto> getOneMonthSummary(final Long userId, final YearMonth yearMonth) {
        final int ONE_MONTH_DAYS = yearMonth.lengthOfMonth();

        final LocalDate startOfMonth = yearMonth.atDay(1);
        final LocalDate endOfMonth = yearMonth.atEndOfMonth();

        final List<DoseRepository.TotalAndPortion> totalAndPortionList
                = doseRepository.countTotalAndTakenByUserIdInPeriod(userId, startOfMonth, endOfMonth);
        final Set<LocalDate> hasOverlappedDates = doseRepository.hasOverlappedIngredientByUserIdInPeriod(userId, startOfMonth, endOfMonth, OVERLAP_PERIOD);

        final Map<LocalDate, OneDaySummaryWithoutDateDto> oneMonthSummary = new HashMap<>(ONE_MONTH_DAYS);

        for (int i = 0; i < ONE_MONTH_DAYS; ++i) {
            final Long total = totalAndPortionList.get(i).getTotal();
            final Long portion = totalAndPortionList.get(i).getPortion();
            final Long progressOrNull = total == 0 ? null : Math.round(portion / (double) total * 100.0);
            final Boolean isOverlapped = hasOverlappedDates.contains(startOfMonth.plusDays(i));

            final OneDaySummaryWithoutDateDto oneDaySummaryWithoutDateDto = new OneDaySummaryWithoutDateDto(progressOrNull, isOverlapped);
            oneMonthSummary.put(startOfMonth.plusDays(i), oneDaySummaryWithoutDateDto);
        }

        return oneMonthSummary;
    }

    public Map<String, Boolean> updateDoseCount(final Long userId, final Map<Long, Double> updateDoseCountDto) {
        final Map<String, Boolean> isUpdatedMap = new HashMap<>(updateDoseCountDto.size());

        for (final Long doseId : updateDoseCountDto.keySet()) {
            final Double count = updateDoseCountDto.get(doseId);
            final Integer isUpdated = doseRepository.updateCountById(doseId, count.longValue(), count.toString().endsWith(".5"));

            isUpdatedMap.put(doseId.toString(), isUpdated == 1);
        }

        return isUpdatedMap;
    }

    public void updateIsTakenByTime(final Long userId, final LocalDate date, final EDosingTime time, final Boolean isTaken) {
        final Integer isUpdatedCount = doseRepository.updateIsTakenByUserIdAndDateAndTime(userId, date, time, isTaken);

        if (isUpdatedCount == 0) {
            throw new CommonException(ErrorCode.NOT_FOUND_DOSE);
        }
    }

    public void updateIsTakenById(final Long userId, final Long doseId, final Boolean isTaken){
        final Integer isUpdatedCount = doseRepository.updateIsTakenByDoseId(userId, doseId, isTaken);

        if (isUpdatedCount == 0) {
            throw new CommonException(ErrorCode.NOT_FOUND_DOSE);
        }
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
                final Dose dose = Dose.builder()
                        .kdCode(KDCode)
                        .ATCCode(ATCCode)
                        .date(oneScheduleDto.getDate())
                        .time(oneScheduleDto.getTime())
                        .pillCnt(oneScheduleDto.getCount().longValue())
                        .isHalf(oneScheduleDto.getCount().toString().endsWith(".5"))
                        .prescription(prescription)
                        .mobileUser(mobileUser)
                        .build();

                final Boolean isOverlapped = doseRepository.existsByMobileUserIdAndKDCodeAndATCCodeAndDateAndTime(
                        userId, KDCode, ATCCode, oneScheduleDto.getDate(), oneScheduleDto.getTime()
                );

                isInserted.add(!isOverlapped);

                if (!isOverlapped) {
                    willSave.add(dose);
                }
            }
        }

        doseRepository.saveAll(willSave);

        return isInserted;
    }

    public void deleteSchedule(final Long userId, final List<Long> ids){
        doseRepository.deleteAllByIdInBatch(ids);
    }
}
