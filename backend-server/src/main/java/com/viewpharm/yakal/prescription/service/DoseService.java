package com.viewpharm.yakal.prescription.service;

import com.viewpharm.yakal.base.PageInfo;
import com.viewpharm.yakal.base.type.EJob;

import com.viewpharm.yakal.prescription.domain.*;
import com.viewpharm.yakal.prescription.dto.request.CreateScheduleDto;
import com.viewpharm.yakal.prescription.dto.request.OneMedicineScheduleDto;
import com.viewpharm.yakal.prescription.dto.request.OneScheduleDto;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
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
import org.springframework.data.domain.Pageable;
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

    private final TakeDoseRepository takeDoseRepository;

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

        List<DoseRepository.overlapDetail> overlapList = doseRepository.findOverlapDetail(userId, date);

        final Map<EDosingTime, List<OverlapDto>> overlapMap = createMap();


        for (DoseRepository.overlapDetail overlapDetail : overlapList) {
            final OverlapDto overlapDto = OverlapDto.builder()
                    .ATCCode(overlapDetail.getATCCode())
                    .KDCodes(overlapDetail.getKDCodes())
                    .build();
            overlapMap.get(overlapDetail.getTime()).add(overlapDto);
        }

        long totalCnt = 0L;

        for (final Dose result : getDoses) {

            final OneTimeScheduleDto oneTimeScheduleDto = OneTimeScheduleDto.builder()
                    .id(result.getId())
                    .KDCode(result.getKDCode().getKdCode())
                    .dosename(result.getKDCode().getDoseName())
                    .ATCCode(result.getATCCode())
                    .isOverlap(overlapMap.containsKey(result.getKDCode().getAtcCode()))
                    .count(result.getPillCnt() + (result.getIsHalf() ? 0.5 : 0))
                    .prescriptionId(result.getPrescription().getId())
                    .build();


            for (TakeDose takeDose : result.getTakeDoses()
                 ) {
                scheduleMap.get(takeDose.getDosingTime()).add(oneTimeScheduleDto);
                totalCnt += oneTimeScheduleDto.getCount().longValue();
            }

        }

        return new OneDayScheduleDto(date.toString(), totalCnt, scheduleMap, overlapMap);
    }

    public Long getOneDayProgressOrNull(final Long userId, final LocalDate date) {
        final oneDaySummary totalAndPortion = takeDoseRepository.countTotalAndTakenByUserIdAndDate(userId, date);

        if (totalAndPortion.getTotal() == 0) {
            return null;
        }

        return Math.round(totalAndPortion.getTake() / (double) totalAndPortion.getTotal() * 100.0);
    }

    public Map<DayOfWeek, OneDaySummaryDto> getOneWeekSummary(final Long userId, final LocalDate date) {
        final int ONE_WEEK_DAYS = DayOfWeek.values().length;

        final LocalDate startOfWeek = date.minusDays(date.getDayOfWeek().getValue() % ONE_WEEK_DAYS);
        final LocalDate endOfWeek = startOfWeek.plusDays(ONE_WEEK_DAYS - 1);

        final List<oneDaySummary> totalAndPortionList
                = takeDoseRepository.countTotalAndTakenByUserIdInPeriod(userId, startOfWeek, endOfWeek);
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
                = takeDoseRepository.countTotalAndTakenByUserIdInPeriod(userId, startOfMonth, endOfMonth);
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
                = takeDoseRepository.countTotalAndTakenByUserIdInPeriod(userId, startDate, endDate);
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
        List<TakeDose> takeDoses = takeDoseRepository.findAllByIdAndDosingTime(doses,dosingTime);
        for (TakeDose takeDose : takeDoses
        ) {
            takeDose.updateIsTaken(isTaken);
        }
    }

    public void updateIsTakenById(final Long doseId, final Boolean isTaken) {
        Dose dose = doseRepository.findById(doseId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_DOSE));
        TakeDose takeDose = takeDoseRepository.findById(dose).orElseThrow(()-> new CommonException(ErrorCode.NOT_FOUND_DOSE));
        takeDose.updateIsTaken(isTaken);
    }

    public List<Boolean> createSchedule(final Long userId, final CreateScheduleDto createScheduleDto, String inputName) {
        final User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        final Prescription prescription = prescriptionRepository.findById(createScheduleDto.getPrescriptionId())
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_PRESCRIPTION));

        final List<Boolean> isInserted = new ArrayList<>();
        final List<Dose> willSave = new ArrayList<>();

        for (final OneMedicineScheduleDto oneMedicineScheduleDto : createScheduleDto.getMedicines()) {
            final String KDCode = oneMedicineScheduleDto.getKDCode();
            final String ATCCode = oneMedicineScheduleDto.getATCCode();

            DoseName doseName = (KDCode != null && ATCCode != null) ? doseNameRepository.findById(KDCode).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_DOSENAME))
                    : doseNameRepository.findByDoseNameSimilar(inputName).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_DOSENAME));

            for (final OneScheduleDto oneScheduleDto : oneMedicineScheduleDto.getSchedules()) {

                Boolean isOverlapped = false; //임시처리
//                doseRepository.findByUserIdAndDate(userId,oneScheduleDto.getDate())
//                final Boolean isOverlapped = takeDoseRepository.existsByDoseAndDosingTime(
//                        dose, oneScheduleDto.getTime()
//                );

                isInserted.add(!isOverlapped);
                log.info("create!");
                if (!isOverlapped) {
                    log.info(doseName.getDoseName().toString());
                    final Dose dose = Dose.builder()
                            .kdCode(doseName)
                            .date(oneScheduleDto.getDate())
                            .pillCnt(oneScheduleDto.getCount().longValue())
                            .isHalf(oneScheduleDto.getCount().toString().endsWith(".5"))
                            .prescription(prescription)
                            .user(user)
                            .build();
                    switch (oneScheduleDto.getTime()){
                        case MORNING -> dose.getTakeDoses().add(new TakeDose(dose,EDosingTime.MORNING,false));
                        case AFTERNOON -> dose.getTakeDoses().add(new TakeDose(dose,EDosingTime.AFTERNOON,false));
                        case EVENING -> dose.getTakeDoses().add(new TakeDose(dose,EDosingTime.EVENING,false));
                        case DEFAULT -> dose.getTakeDoses().add(new TakeDose(dose,EDosingTime.DEFAULT,false));
                    }
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
        userRepository.findByIdAndJobOrJob(userId, EJob.DOCTOR, EJob.PHARMACIST)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
        final User patient = userRepository.findById(patientId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        return doseRepository.findTop5ByUserAndIsDeletedOrderByCreatedDesc(patient.getId()).stream()
                .map(d -> new DoseRecentDto(d.getName(), d.getPrescribedAt().toLocalDateTime().toLocalDate()))
                .collect(Collectors.toList());
    }

    public DoseAllDto readAllDoses(Long userId, Long patientId, Long pageIndex) {
        userRepository.findByIdAndJobOrJob(userId, EJob.DOCTOR, EJob.PHARMACIST)
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
        userRepository.findByIdAndJobOrJob(userId, EJob.DOCTOR, EJob.PHARMACIST)
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
        userRepository.findByIdAndJobOrJob(userId, EJob.DOCTOR, EJob.PHARMACIST)
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
