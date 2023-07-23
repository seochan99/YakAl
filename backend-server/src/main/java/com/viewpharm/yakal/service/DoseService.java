package com.viewpharm.yakal.service;


import com.viewpharm.yakal.domain.Dose;

import com.viewpharm.yakal.domain.Prescription;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.DoesRequestDto;
import com.viewpharm.yakal.dto.DoseDto;
import com.viewpharm.yakal.dto.PercentDto;
import com.viewpharm.yakal.dto.ResponseDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.DoseRepository;
import com.viewpharm.yakal.repository.PrescriptionRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.EDosingTime;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.*;

@Slf4j
@Service
@Transactional
public class DoseService {

    private final UserRepository userRepository;
    private final DoseRepository doseRepository;

    private final PrescriptionRepository prescriptionRepository;
    @Autowired
    public DoseService(UserRepository userRepository, DoseRepository doseRepository, PrescriptionRepository prescriptionRepository) {
        this.userRepository = userRepository;
        this.doseRepository = doseRepository;
        this.prescriptionRepository = prescriptionRepository;
    }





    public ResponseDto<DoseDto> getDayDoseSchedule(final Long userId, final LocalDate date){

        User user = userRepository.findById(userId).orElseThrow(()->new CommonException(ErrorCode.NOT_FOUND_USER));
        List<Dose> results = doseRepository.findByUserIdAndDate(1L ,date);
        Map<EDosingTime, List<DoseDto.Pill>> dosesByTime = new HashMap<>();

        for (Dose result : results) {
            DoseDto.Pill pill = DoseDto.Pill.builder().
                    pillName(result.getPillName()).
                    isTaken(result.getIsTaken())
                    .cnt(result.getPillCnt())
                    .isHalf(result.getIsHalf())
                    .build();

            // 해당 그룹의 List<Pill>를 가져옴, 없을 경우 새로 생성
            List<DoseDto.Pill> groupDoses = dosesByTime.getOrDefault(result.getTime(), new ArrayList<>());

            // 그룹에 속한 Pill 객체 추가
            groupDoses.add(pill);

            // Map에 그룹별 Pill 리스트 저장
            dosesByTime.put(result.getTime(), groupDoses);
        }

        return new ResponseDto<>(HttpStatus.OK,true,DoseDto.builder().dosesByTime(dosesByTime).build(),null);
    }

    public int getPercent(List<Dose> doses){
        Long takens = doses.stream()
                .filter(dose -> dose.getIsTaken())
                .count();
        Long total = doses.stream().count();

        double percentage = (takens.doubleValue() / total.doubleValue()) * 100.0;
        int result = (int) Math.round(percentage); // 소수점 첫째 자리에서 반올림하여 정수로 변환

        return result;
    }

    public ResponseDto<PercentDto> getDayDosePercent(final Long userId, final LocalDate date){
        userRepository.findById(userId).orElseThrow(()->new CommonException(ErrorCode.NOT_FOUND_USER));
        List<Dose> doses = doseRepository.findByUserIdAndDate(userId,date);

        return new ResponseDto<>(HttpStatus.OK,true, PercentDto.builder().percent(getPercent(doses)).build(),null);
    }

    public ResponseDto<PercentDto> getDayDosePercent(final User user, final LocalDate date){
        List<Dose> doses = doseRepository.findByUserIdAndDate(user.getId(),date);

        return new ResponseDto<>(HttpStatus.OK,true, PercentDto.builder().percent(getPercent(doses)).build(),null);
    }

    public ResponseDto<List<PercentDto>> getDayWeekPercent(final Long userId, final LocalDate date){
        User user = userRepository.findById(userId).orElseThrow(()->new CommonException(ErrorCode.NOT_FOUND_USER));
        List<PercentDto> result = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            result.add(getDayDosePercent(user,date.plusDays(i)).getData());
        }

        return new ResponseDto<>(HttpStatus.OK,true, result,null);
    }

    public ResponseDto<List<PercentDto>> getDayMonthPercent(final Long userId, final LocalDate date){
        User user = userRepository.findById(userId).orElseThrow(()->new CommonException(ErrorCode.NOT_FOUND_USER));
        LocalDate firstDayOfMonth = date.withDayOfMonth(1);
        List<PercentDto> result = new ArrayList<>();
        for (int i = 0; i < date.lengthOfMonth(); i++) {
            result.add(getDayDosePercent(user,firstDayOfMonth.plusDays(i)).getData());
        }

        return new ResponseDto<>(HttpStatus.OK,Boolean.TRUE, result,null);
    }

    public ResponseDto<Boolean> updateDoseTakeByTime(final Long userId,final LocalDate date, EDosingTime time){
        User user = userRepository.findById(userId).orElseThrow(()->new CommonException(ErrorCode.NOT_FOUND_USER));
        List<Dose> doses =doseRepository.findByUserIdAndDateAndTime(userId,date,time);

        if (doses == null || doses.isEmpty()) {
            throw new CommonException(ErrorCode.NOT_FOUND_DOSE);
        }

        for (Dose d: doses
             ) {
            d.setIsTaken(true);
        }
        doseRepository.saveAll(doses);
        return new ResponseDto<>(HttpStatus.OK,true, true,null);
    }

    public ResponseDto<Boolean> updateDoseTakeByTimeAndPillName(final Long userId,final LocalDate date, EDosingTime time,String pillName){
        userRepository.findById(userId).orElseThrow(()->new CommonException(ErrorCode.NOT_FOUND_USER));
        Dose dose = doseRepository.findByUserIdAndDateAndTimeAndPillName(userId,date,time,pillName).orElseThrow(()->new CommonException(ErrorCode.NOT_FOUND_DOSE));
        dose.setIsTaken(true);
        return new ResponseDto<>(HttpStatus.OK,true, true,null);
    }

    public ResponseDto<Boolean> createSchedule(final Long userId, final DoesRequestDto doesRequestDto){
        User user = userRepository.findById(userId).orElseThrow(()->new CommonException(ErrorCode.NOT_FOUND_USER));
        Prescription pre = prescriptionRepository.findByUserAndRecNum(user,doesRequestDto.getRecNum()).orElseThrow(()->new CommonException(ErrorCode.NOT_FOUND_USER));
        doseRepository.save(Dose.builder()
                        .date(doesRequestDto.getDate())
                        .time(doesRequestDto.getTime())
                        .pillName(doesRequestDto.getPillName())
                        .isHalf(doesRequestDto.getIsHalf())
                        .pillCnt(doesRequestDto.getPillCnt())
                        .prescription(pre)
                        .user(user)
                .build());
        return new ResponseDto<>(HttpStatus.OK,true, true,null);
    }

    public ResponseDto<Boolean> createSchedules(final Long userId, final List<DoesRequestDto> doesRequestDtoList){
        User user = userRepository.findById(userId).orElseThrow(()->new CommonException(ErrorCode.NOT_FOUND_USER));
        Prescription pre = prescriptionRepository.findByUserAndRecNum(user, doesRequestDtoList.get(0).getRecNum())
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        List<Dose> doses = new ArrayList<>();
        for (DoesRequestDto doesRequestDto : doesRequestDtoList) {

            Dose dose = Dose.builder()
                    .date(doesRequestDto.getDate())
                    .time(doesRequestDto.getTime())
                    .pillName(doesRequestDto.getPillName())
                    .isHalf(doesRequestDto.getIsHalf())
                    .pillCnt(doesRequestDto.getPillCnt())
                    .prescription(pre)
                    .user(user)
                    .build();
            doses.add(dose);
        }

        doseRepository.saveAll(doses);
        return new ResponseDto<>(HttpStatus.OK,true, true,null);
    }



}
