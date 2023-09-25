package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Diagnosis;
import com.viewpharm.yakal.domain.HealthFood;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.request.HealthFoodRequestDto;
import com.viewpharm.yakal.dto.response.DiagnosisListDto;
import com.viewpharm.yakal.dto.response.HealthFoodListDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.HealthFoodRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.EJob;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;
//비타민으로 변경 예정
@Deprecated
@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class HealthFoodService {
    private final HealthFoodRepository healthFoodRepository;
    private final UserRepository userRepository;

    public Boolean createHealthFood(Long userId, HealthFoodRequestDto requestDto) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (requestDto.getName().length() == 0)
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);

        healthFoodRepository.findByName(requestDto.getName())
                .ifPresent(h -> {
                    throw new CommonException(ErrorCode.DUPLICATION_HEALTHFOOD);
                });

        healthFoodRepository.save(HealthFood.builder()
                .name(requestDto.getName())
                .user(user)
                .build());

        return Boolean.TRUE;
    }

    //read없음

    public Boolean updateHealthFood(Long userId, Long healthFoodId, HealthFoodRequestDto requestDto) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        HealthFood healthFood = healthFoodRepository.findById(healthFoodId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_HEALTHFOOD));

        if (requestDto.getName().length() == 0)
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);

        //전문가는 못 고치도록 함
        if (healthFood.getUser().getId() != userId)
            throw new CommonException(ErrorCode.NOT_EQUAL);

        //중복검사
        healthFoodRepository.findByName(requestDto.getName())
                .ifPresent(h -> {
                    throw new CommonException(ErrorCode.DUPLICATION_HEALTHFOOD);
                });

        if (requestDto.getName().length() == 0)
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);

        healthFood.modifyHealthFood(requestDto.getName());

        return Boolean.TRUE;
    }

    public Boolean deleteHealthFood(Long userId, Long healthFoodId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

       HealthFood healthFood = healthFoodRepository.findById(healthFoodId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_HEALTHFOOD));

        //전문가는 못 삭제 하도록 함
        if (healthFood.getUser().getId() != userId)
            throw new CommonException(ErrorCode.NOT_EQUAL);

        healthFoodRepository.delete(healthFood);

        return Boolean.TRUE;
    }
    //자신의 건강 식품 리스트
    public List<HealthFoodListDto> getHealthFoodList(Long userId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<HealthFood> healthFoods = healthFoodRepository.findAllByUser(user);

        List<HealthFoodListDto> listDtos = healthFoods.stream()
                .map(h -> new HealthFoodListDto(h.getId(), h.getName()))
                .collect(Collectors.toList());

        return listDtos;
    }

    //전문가가 환자의 건강 식품 리스트
    public List<HealthFoodListDto> getHealthFoodListForExpert(Long expertId,Long patientId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //유저 확인
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<HealthFood> healthFoods = healthFoodRepository.findAllByUser(patient);

        List<HealthFoodListDto> listDtos = healthFoods.stream()
                .map(h -> new HealthFoodListDto(h.getId(), h.getName()))
                .collect(Collectors.toList());

        return listDtos;
    }

}
