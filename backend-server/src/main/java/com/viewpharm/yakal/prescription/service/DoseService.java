package com.viewpharm.yakal.prescription.service;

import com.viewpharm.yakal.base.dto.PageInfo;
import com.viewpharm.yakal.base.type.EJob;

import com.viewpharm.yakal.prescription.domain.*;
import com.viewpharm.yakal.prescription.dto.request.CreateScheduleDto;
import com.viewpharm.yakal.prescription.dto.request.OneMedicineScheduleDto;
import com.viewpharm.yakal.prescription.dto.request.OneScheduleDto;
import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import com.viewpharm.yakal.prescription.dto.response.*;
import com.viewpharm.yakal.prescription.repository.*;
import com.viewpharm.yakal.base.type.EDosingTime;
import com.viewpharm.yakal.base.type.EPeriod;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class DoseService {

    private final UserRepository userRepository;
    private final DoseRepository doseRepository;
    private final PrescriptionRepository prescriptionRepository;
    private final RiskRepository riskRepository;
    private final DoseNameRepository doseNameRepository;

    public <T> Map<EDosingTime, List<T>> createMap() {
        Map<EDosingTime, List<T>> map = new HashMap<>(EDosingTime.values().length);
        map.put(EDosingTime.MORNING, new ArrayList<>());
        map.put(EDosingTime.AFTERNOON, new ArrayList<>());
        map.put(EDosingTime.EVENING, new ArrayList<>());
        map.put(EDosingTime.DEFAULT, new ArrayList<>());
        return map;
    }

    public OneDayScheduleDto getOneDaySchedule(Long userId, LocalDate date) {
        final List<Dose> getDoses = doseRepository.findByUserIdAndDate(userId, date);
        final Map<EDosingTime, List<OneTimeScheduleDto>> scheduleMap = createMap();

        final Map<EDosingTime, List<OverlapDto>> overlapMap = createMap();


        for (DoseRepository.overlapDetail overlapDetail : doseRepository.findOverlapDetailMorning(userId, date)) {
            final OverlapDto overlapDto = OverlapDto.builder()
                    .ATCCode(overlapDetail.getATCCode())
                    .KDCodes(overlapDetail.getKDCodes())
                    .build();
            overlapMap.get(EDosingTime.MORNING).add(overlapDto);
        }

        for (DoseRepository.overlapDetail overlapDetail : doseRepository.findOverlapDetailAfternoon(userId, date)) {
            final OverlapDto overlapDto = OverlapDto.builder()
                    .ATCCode(overlapDetail.getATCCode())
                    .KDCodes(overlapDetail.getKDCodes())
                    .build();
            overlapMap.get(EDosingTime.AFTERNOON).add(overlapDto);
        }

        for (DoseRepository.overlapDetail overlapDetail : doseRepository.findOverlapDetailEvening(userId, date)) {
            final OverlapDto overlapDto = OverlapDto.builder()
                    .ATCCode(overlapDetail.getATCCode())
                    .KDCodes(overlapDetail.getKDCodes())
                    .build();
            overlapMap.get(EDosingTime.EVENING).add(overlapDto);
        }

        for (DoseRepository.overlapDetail overlapDetail : doseRepository.findOverlapDetailDefault(userId, date)) {
            final OverlapDto overlapDto = OverlapDto.builder()
                    .ATCCode(overlapDetail.getATCCode())
                    .KDCodes(overlapDetail.getKDCodes())
                    .build();
            overlapMap.get(EDosingTime.DEFAULT).add(overlapDto);
        }

        long totalCnt = 0L;

        for (final Dose result : getDoses) {

            if (result.getExistMorning()) {
                final OneTimeScheduleDto oneTimeScheduleDto = OneTimeScheduleDto.builder()
                        .id(result.getId())
                        .KDCode(result.getKDCode().getKdCode())
                        .dosename(result.getKDCode().getDoseName())
                        .ATCCode(result.getATCCode())
                        .isTaken(result.getIsMorningTaken())
                        .isOverlap(overlapMap.containsKey(result.getATCCode().getAtcCode()))
                        .count(result.getPillCnt() + (result.getIsHalf() ? 0.5 : 0))
                        .prescriptionId(result.getPrescription().getId())
                        .build();
                totalCnt += oneTimeScheduleDto.getCount().longValue();
                scheduleMap.get(EDosingTime.MORNING).add(oneTimeScheduleDto);
            }

            if (result.getExistAfternoon()) {
                final OneTimeScheduleDto oneTimeScheduleDto = OneTimeScheduleDto.builder()
                        .id(result.getId())
                        .KDCode(result.getKDCode().getKdCode())
                        .dosename(result.getKDCode().getDoseName())
                        .ATCCode(result.getATCCode())
                        .isTaken(result.getIsAfternoonTaken())
                        .isOverlap(overlapMap.containsKey(result.getATCCode().getAtcCode()))
                        .count(result.getPillCnt() + (result.getIsHalf() ? 0.5 : 0))
                        .prescriptionId(result.getPrescription().getId())
                        .build();
                totalCnt += oneTimeScheduleDto.getCount().longValue();
                scheduleMap.get(EDosingTime.AFTERNOON).add(oneTimeScheduleDto);
            }

            if (result.getExistEvening()) {
                final OneTimeScheduleDto oneTimeScheduleDto = OneTimeScheduleDto.builder()
                        .id(result.getId())
                        .KDCode(result.getKDCode().getKdCode())
                        .dosename(result.getKDCode().getDoseName())
                        .ATCCode(result.getATCCode())
                        .isTaken(result.getIsEveningTaken())
                        .isOverlap(overlapMap.containsKey(result.getATCCode().getAtcCode()))
                        .count(result.getPillCnt() + (result.getIsHalf() ? 0.5 : 0))
                        .prescriptionId(result.getPrescription().getId())
                        .build();
                totalCnt += oneTimeScheduleDto.getCount().longValue();
                scheduleMap.get(EDosingTime.EVENING).add(oneTimeScheduleDto);
            }

            if (result.getExistDefault()) {
                final OneTimeScheduleDto oneTimeScheduleDto = OneTimeScheduleDto.builder()
                        .id(result.getId())
                        .KDCode(result.getKDCode().getKdCode())
                        .dosename(result.getKDCode().getDoseName())
                        .ATCCode(result.getATCCode())
                        .isTaken(result.getIsDefaultTaken())
                        .isOverlap(overlapMap.containsKey(result.getATCCode().getAtcCode()))
                        .count(result.getPillCnt() + (result.getIsHalf() ? 0.5 : 0))
                        .prescriptionId(result.getPrescription().getId())
                        .build();
                totalCnt += oneTimeScheduleDto.getCount().longValue();
                scheduleMap.get(EDosingTime.DEFAULT).add(oneTimeScheduleDto);
            }

        }

        final OneDayScheduleDto oneDayScheduleDto = new OneDayScheduleDto(date.toString(), totalCnt, scheduleMap, overlapMap);

        return oneDayScheduleDto;
    }

//    public Long getOneDayProgressOrNull(final Long userId, final LocalDate date) {
//        final oneDaySummary totalAndPortion = doseRepository.countTotalAndTakenByUserIdAndDate(userId, date);
//
//        if (totalAndPortion.getTotal() == 0) {
//            return null;
//        }
//
//        return Math.round(totalAndPortion.getTake() / (double) totalAndPortion.getTotal() * 100.0);
//    }

    public Map<DayOfWeek, OneDaySummaryDto> getOneWeekSummary(final Long userId, final LocalDate date) {
        final int ONE_WEEK_DAYS = DayOfWeek.values().length;

        final LocalDate startOfWeek = date.minusDays(date.getDayOfWeek().getValue() % ONE_WEEK_DAYS);
        final LocalDate endOfWeek = startOfWeek.plusDays(ONE_WEEK_DAYS - 1);

        final List<oneDaySummary> totalAndPortionList
                = doseRepository.countTotalAndTakenByUserIdInPeriod(userId, startOfWeek, endOfWeek);
        final List<DoseRepository.overlap> overlapList
                = doseRepository.findOverlap(userId, startOfWeek, endOfWeek);

        final Map<DayOfWeek, OneDaySummaryDto> oneWeekSummary = new HashMap<>(ONE_WEEK_DAYS);

        // 일주일 각 날짜에 대한 처리
        for (int i = 0; i < ONE_WEEK_DAYS; ++i) {
            Long progressOrNull = null; // 초기값을 null로 설정
            LocalDate currentDate = startOfWeek.plusDays(i); // 현재 날짜 계산
            Boolean isOverlapped = false;


            for (oneDaySummary summary : totalAndPortionList) {
                //성분 중복 검사
                for (DoseRepository.overlap overlap : overlapList
                ) {
                    if (overlap.getDate().equals(currentDate)) {
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
            final OneDaySummaryDto oneDaySummaryDto = new OneDaySummaryDto(currentDate.toString(), progressOrNull, isOverlapped);
            oneWeekSummary.put(DayOfWeek.values()[(i + ONE_WEEK_DAYS - 1) % ONE_WEEK_DAYS], oneDaySummaryDto);
        }

        return oneWeekSummary;

    }


    public List<OneDaySummaryDto> getOneMonthSummary(final Long userId, final YearMonth yearMonth) {
        final int ONE_MONTH_DAYS = yearMonth.lengthOfMonth();

        final LocalDate startOfMonth = yearMonth.atDay(1);
        final LocalDate endOfMonth = yearMonth.atEndOfMonth();

        final List<oneDaySummary> totalAndPortionList
                = doseRepository.countTotalAndTakenByUserIdInPeriod(userId, startOfMonth, endOfMonth);
        final List<DoseRepository.overlap> overlapList
                = doseRepository.findOverlap(userId, startOfMonth, endOfMonth);

        List<OneDaySummaryDto> oneMonthSummary = new ArrayList<>();

        for (int i = 0; i < ONE_MONTH_DAYS; ++i) {
            Long progressOrNull = null; // 초기값을 null로 설정
            LocalDate currentDate = startOfMonth.plusDays(i); // 현재 날짜 계산
            boolean isOverlapped = false;

            // 결과 리스트에서 현재 날짜와 일치하는 데이터 찾기
            for (oneDaySummary summary : totalAndPortionList) {
                //성분 중복 검사
                for (DoseRepository.overlap overlap : overlapList
                ) {
                    if (overlap.getDate().equals(currentDate)) {
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

            final OneDaySummaryDto oneDaySummary = new OneDaySummaryDto(currentDate.toString(), progressOrNull, isOverlapped);
            oneMonthSummary.add(oneDaySummary);

        }

        return oneMonthSummary;
    }

    public List<OneDaySummaryDto> getBetweenDaySummary(final Long userId, final LocalDate startDate, final LocalDate endDate) {
        final List<oneDaySummary> totalAndPortionList
                = doseRepository.countTotalAndTakenByUserIdInPeriod(userId, startDate, endDate);
        final List<DoseRepository.overlap> overlapList
                = doseRepository.findOverlap(userId, startDate, endDate);

        List<OneDaySummaryDto> oneMonthSummary = new ArrayList<>();

        for (int i = 0; i <= ChronoUnit.DAYS.between(startDate, endDate); ++i) {
            long progress = 0L; // 초기값을 0으로 설정
            LocalDate currentDate = startDate.plusDays(i); // 현재 날짜 계산
            boolean isOverlapped = false;

            // 결과 리스트에서 현재 날짜와 일치하는 데이터 찾기
            for (oneDaySummary summary : totalAndPortionList) {
                //성분 중복 검사
                for (DoseRepository.overlap overlap : overlapList
                ) {
                    if (overlap.getDate().equals(currentDate)) {
                        isOverlapped = true;
                        break;
                    }
                }

                if (summary.getDate().equals(startDate.plusDays(i))) {
                    Long total = summary.getTotal();
                    Long portion = summary.getTake();
                    progress = (total == null || total == 0) ? 0L : Math.round(portion / (double) total * 100.0);
                    break;
                }
            }

            final OneDaySummaryDto oneDaySummary = new OneDaySummaryDto(currentDate.toString(), progress, isOverlapped);
            oneMonthSummary.add(oneDaySummary);

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

    public void updateIsTakenByTime(final Long userId, final LocalDate date, final EDosingTime dosingTime, final Boolean isTaken) {
        List<Dose> doses = doseRepository.findByUserIdAndDate(userId, date);
        for (Dose dose : doses
        ) {
            switch (dosingTime) {
                case MORNING -> dose.updateMorningTaken(isTaken);
                case AFTERNOON -> dose.updateAfternoonTaken(isTaken);
                case EVENING -> dose.updateEveningTaken(isTaken);
                case DEFAULT -> dose.updateDefaultTaken(isTaken);
            }
        }
    }

    public void updateIsTakenById(final Long doseId, final Boolean isTaken, final EDosingTime dosingTime) {
        Dose dose = doseRepository.findById(doseId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_DOSE));
        switch (dosingTime) {
            case MORNING -> dose.updateMorningTaken(isTaken);
            case AFTERNOON -> dose.updateAfternoonTaken(isTaken);
            case EVENING -> dose.updateEveningTaken(isTaken);
            case DEFAULT -> dose.updateDefaultTaken(isTaken);
        }
    }

    public List<Boolean> createSchedule(final Long userId, final CreateScheduleDto createScheduleDto) {
        final User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        final Prescription prescription = prescriptionRepository.findById(createScheduleDto.getPrescriptionId())
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_PRESCRIPTION));

        final List<Boolean> isInserted = new ArrayList<>();
        final List<Dose> willSave = new ArrayList<>();

        for (final OneMedicineScheduleDto oneMedicineScheduleDto : createScheduleDto.getMedicines()) {
            final String KDCode = oneMedicineScheduleDto.getKDCode();
            final String ATCCode = oneMedicineScheduleDto.getATCCode();

            DoseName doseName = doseNameRepository.findById(KDCode).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_DOSENAME));
            Risk risk = riskRepository.findById(ATCCode).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_RISK));

            for (final OneScheduleDto oneScheduleDto : oneMedicineScheduleDto.getSchedules()) {

                Boolean isOverlapped = false;
                if (oneScheduleDto.getTime().get(0)) {
                    isOverlapped = doseRepository.existsByUserIdAndKDCodeAndDateAndExistMorningTrue(userId, doseName, oneScheduleDto.getDate());
                }
                if (oneScheduleDto.getTime().get(1) && !isOverlapped) {
                    isOverlapped = doseRepository.existsByUserIdAndKDCodeAndDateAndExistMorningTrue(userId, doseName, oneScheduleDto.getDate());
                }
                if (oneScheduleDto.getTime().get(2) && !isOverlapped) {
                    isOverlapped = doseRepository.existsByUserIdAndKDCodeAndDateAndExistEveningTrue(userId, doseName, oneScheduleDto.getDate());
                }
                if (oneScheduleDto.getTime().get(3) && !isOverlapped) {
                    isOverlapped = doseRepository.existsByUserIdAndKDCodeAndDateAndExistDefaultTrue(userId, doseName, oneScheduleDto.getDate());
                }
                isInserted.add(!isOverlapped);

                if (!isOverlapped) {

                    final Dose dose = Dose.builder()
                            .KDCode(doseName)
                            .ATCCode(risk)
                            .date(oneScheduleDto.getDate())
                            .pillCnt(oneScheduleDto.getCount().longValue())
                            .isHalf(oneScheduleDto.getCount().toString().endsWith(".5"))
                            .prescription(prescription)
                            .user(user)
                            .existMorning(oneScheduleDto.getTime().get(0))
                            .existAfternoon(oneScheduleDto.getTime().get(1))
                            .existEvening(oneScheduleDto.getTime().get(2))
                            .existDefault(oneScheduleDto.getTime().get(3))
                            .build();

                    willSave.add(dose);
                }

            }
        }

        doseRepository.saveAll(willSave);

        return isInserted;
    }

    public PrescribedDto getPrescribedDoses(final Long userId, Integer pageIndex, Integer pageSize, EPeriod ePeriod) {
        userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        final LocalDate today = LocalDate.now();
        LocalDate lastDate = null;

        switch (ePeriod) {
            case WEEK -> lastDate = today.minusDays(7);
            case MONTH -> lastDate = today.minusMonths(1);
            case THREEMONTH -> lastDate = today.minusMonths(3);
            case HALFYEAR -> lastDate = today.minusMonths(6);
            case YEAR -> lastDate = today.minusYears(1L);
            case ALL -> lastDate = today.minusYears(100L);
        }

        List<DoseRepository.prescribed> prescribeds = doseRepository.findAllByUserIdAndLastDate(userId, lastDate);

        List<DoseRepository.prescribed> sublist;

        if (prescribeds.size() <= (pageIndex + 1) * pageSize) {
            sublist = prescribeds.subList(pageIndex * pageSize, prescribeds.size());
        } else {
            sublist = prescribeds.subList(pageIndex * pageSize, (pageIndex + 1) * pageSize);
        }

        List<PrescribedItemDto> prescribedDtoList = sublist.stream()
                .map(b -> new PrescribedItemDto(b.getName(), b.getScore(), b.getPrescribedDate()))
                .collect(Collectors.toList());

        return new PrescribedDto(prescribedDtoList, prescribeds.size());
    }

    public DoseCodesDto getKDCodeAndATCCode(String dosename) {
        DoseName dose = doseNameRepository.findByDoseName(dosename).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_DOSENAME));
        DoseCodesDto result = DoseCodesDto.builder()
                .atcCode(dose.getAtcCode())
                .kdCode(dose.getKdCode())
                .build();
        return result;
    }

    public void deleteSchedule(final List<Long> ids) {
        doseRepository.deleteAllByIdInBatch(ids);
    }

    public List<DoseRecentDto> readRecentDoses(Long userId, Long patientId) {
        userRepository.findExpertById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
        final User patient = userRepository.findById(patientId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        return doseRepository.findTop5ByUserAndIsDeletedOrderByCreatedDesc(patient.getId()).stream()
                .map(d -> new DoseRecentDto(d.getName(), d.getPrescribedAt().toLocalDateTime().toLocalDate()))
                .collect(Collectors.toList());
    }

    public DoseAllDto readAllDoses(Long userId, Long patientId, Long pageIndex) {
        userRepository.findExpertById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
        final User patient = userRepository.findById(patientId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        final int PAGE_SIZE = 5;

        final PageRequest paging = PageRequest.of(pageIndex.intValue(), PAGE_SIZE, Sort.by(Sort.Direction.DESC, "created_at"));
        final Page<DoseRepository.doseInfo> doses = doseRepository.findByUserAndIsDeletedOrderByCreatedDesc(patient.getId(), paging);
        final PageInfo pageInfo = PageInfo.builder()
                .page(pageIndex.intValue())
                .size(PAGE_SIZE)
                .totalElements((int) doses.getTotalElements())
                .totalPages(doses.getTotalPages())
                .build();

        final List<DoseRecentDto> doseRecentDtoList = doses.stream()
                .map(d -> new DoseRecentDto(d.getName(), d.getPrescribedAt().toLocalDateTime().toLocalDate()))
                .collect(Collectors.toList());

        return DoseAllDto.builder()
                .datalist(doseRecentDtoList)
                .pageInfo(pageInfo)
                .build();
    }

    public DoseAllDto readBeerCriteriaDoses(Long userId, Long patientId, Long pageIndex) {
        userRepository.findExpertById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
        final User patient = userRepository.findById(patientId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        final int PAGE_SIZE = 5;

        final PageRequest paging = PageRequest.of(pageIndex.intValue(), PAGE_SIZE, Sort.by(Sort.Direction.DESC, "created_at"));
        final Page<DoseRepository.doseInfo> doses = doseRepository.findByUserAndIsDeletedAndIsBeersOrderByCreatedDesc(patient.getId(), paging);
        final PageInfo pageInfo = PageInfo.builder()
                .page(pageIndex.intValue())
                .size(PAGE_SIZE)
                .totalElements((int) doses.getTotalElements())
                .totalPages(doses.getTotalPages())
                .build();

        List<DoseRecentDto> doseDtoList = doses.stream()
                .map(d -> new DoseRecentDto(d.getName(), d.getPrescribedAt().toLocalDateTime().toLocalDate()))
                .collect(Collectors.toList());

        return DoseAllDto.builder()
                .datalist(doseDtoList)
                .pageInfo(pageInfo)
                .build();
    }

    public DoseAllWithRiskDto readAnticholinergicDoses(Long userId, Long patientId, Long pageIndex) {
        userRepository.findExpertById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
        final User patient = userRepository.findById(patientId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        final int PAGE_SIZE = 5;

        final PageRequest paging = PageRequest.of(pageIndex.intValue(), PAGE_SIZE, Sort.by(Sort.Direction.DESC, "created_at"));
        final Page<DoseRepository.anticholinergicDoseInfo> doses = doseRepository.findByUserAndIsDeletedAndIsAnticholinergicOrderByCreatedDesc(patient.getId(), paging);
        final PageInfo pageInfo = PageInfo.builder()
                .page(pageIndex.intValue())
                .size(PAGE_SIZE)
                .totalElements((int) doses.getTotalElements())
                .totalPages(doses.getTotalPages())
                .build();

        final List<AnticholinergicDoseDto> doseDtoList = doses.stream()
                .map(d -> new AnticholinergicDoseDto(d.getName(), d.getPrescribedAt().toLocalDateTime().toLocalDate(), d.getScore()))
                .collect(Collectors.toList());

        return DoseAllWithRiskDto.builder()
                .datalist(doseDtoList)
                .pageInfo(pageInfo)
                .build();
    }
}
