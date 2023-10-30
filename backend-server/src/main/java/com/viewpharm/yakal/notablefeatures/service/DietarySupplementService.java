package com.viewpharm.yakal.notablefeatures.service;

import com.viewpharm.yakal.notablefeatures.domain.DietarySupplement;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.notablefeatures.dto.request.NotableFeatureRequestDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.notablefeatures.dto.response.NotableFeatureStringResponseDto;
import com.viewpharm.yakal.repository.HealthFoodRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.EJob;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;
@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class DietarySupplementService {
    private final HealthFoodRepository healthFoodRepository;
    private final UserRepository userRepository;

    public Boolean createHealthFood(Long userId, NotableFeatureRequestDto requestDto) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (requestDto.getNotableFeature().length() == 0)
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);

        healthFoodRepository.findByName(requestDto.getNotableFeature())
                .ifPresent(h -> {
                    throw new CommonException(ErrorCode.DUPLICATION_HEALTHFOOD);
                });

        healthFoodRepository.save(DietarySupplement.builder()
                .name(requestDto.getNotableFeature())
                .user(user)
                .build());

        return Boolean.TRUE;
    }

    public Boolean deleteHealthFood(Long userId, Long healthFoodId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

       DietarySupplement dietarySupplement = healthFoodRepository.findById(healthFoodId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_HEALTHFOOD));

        //전문가는 못 삭제 하도록 함
        if (dietarySupplement.getUser().getId() != userId)
            throw new CommonException(ErrorCode.NOT_EQUAL);

        healthFoodRepository.delete(dietarySupplement);

        return Boolean.TRUE;
    }
    //자신의 건강 식품 리스트
    public List<NotableFeatureStringResponseDto> getHealthFoodList(Long userId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<DietarySupplement> dietarySupplements = healthFoodRepository.findAllByUser(user);

        List<NotableFeatureStringResponseDto> result = dietarySupplements.stream()
                .map(h -> new NotableFeatureStringResponseDto(h.getId(), h.getName()))
                .collect(Collectors.toList());

        return result;
    }

    //전문가가 환자의 건강 식품 리스트
    public List<NotableFeatureStringResponseDto> getHealthFoodListForExpert(Long expertId,Long patientId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //유저 확인
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<DietarySupplement> dietarySupplements = healthFoodRepository.findAllByUser(patient);

        List<NotableFeatureStringResponseDto> result = dietarySupplements.stream()
                .map(h -> new NotableFeatureStringResponseDto(h.getId(), h.getName()))
                .collect(Collectors.toList());

        return result;
    }

}
