package com.viewpharm.yakal.notablefeature.service;

import com.viewpharm.yakal.notablefeature.domain.DietarySupplement;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.notablefeature.dto.request.NotableFeatureDto;
import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import com.viewpharm.yakal.notablefeature.dto.response.NotableFeatureStringDto;
import com.viewpharm.yakal.notablefeature.repository.DietarySupplementRepository;
import com.viewpharm.yakal.user.repository.UserRepository;
import com.viewpharm.yakal.base.type.EJob;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;
@Slf4j
@Service
@RequiredArgsConstructor
public class DietarySupplementService {
    private final DietarySupplementRepository dietarySupplementRepository;
    private final UserRepository userRepository;

    public Boolean createDietarySupplement(Long userId, NotableFeatureDto requestDto) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (requestDto.getNotableFeature().isEmpty())
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);

        dietarySupplementRepository.findByName(requestDto.getNotableFeature())
                .ifPresent(h -> {
                    throw new CommonException(ErrorCode.DUPLICATION_NOTABLE_FEATURE);
                });

        dietarySupplementRepository.save(DietarySupplement.builder()
                .name(requestDto.getNotableFeature())
                .user(user)
                .build());

        return Boolean.TRUE;
    }

    //자신의 건강 식품 리스트
    public List<NotableFeatureStringDto> readDietarySupplements(Long userId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<DietarySupplement> dietarySupplements = dietarySupplementRepository.findAllByUserOrderByIdDesc(user);

        return dietarySupplements.stream()
                .map(dietarySupplement -> new NotableFeatureStringDto(dietarySupplement.getId(), dietarySupplement.getName()))
                .collect(Collectors.toList());
    }

    public Boolean deleteDietarySupplement(Long userId, Long healthFoodId) {
       DietarySupplement dietarySupplement = dietarySupplementRepository.findById(healthFoodId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_NOTABLE_FEATURE));

        //전문가는 못 삭제 하도록 함
        if (dietarySupplement.getUser().getId() != userId)
            throw new CommonException(ErrorCode.NOT_EQUAL);

        dietarySupplementRepository.delete(dietarySupplement);

        return Boolean.TRUE;
    }

    //전문가가 환자의 건강 식품 리스트
    public List<NotableFeatureStringDto> getHealthFoodListForExpert(Long expertId, Long patientId) {
//        //전문가 확인
//        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
//
//        //유저 확인
//        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
//
//        List<DietarySupplement> dietarySupplements = dietarySupplementRepository.findAllByUserOrderByIdDesc(patient);
//
//        List<NotableFeatureStringDto> result = dietarySupplements.stream()
//                .map(h -> new NotableFeatureStringDto(h.getId(), h.getName()))
//                .collect(Collectors.toList());
//
//        return result;
        return null;
    }
}
