package com.viewpharm.yakal.notablefeatures.service;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.notablefeatures.domain.Allergy;
import com.viewpharm.yakal.notablefeatures.dto.request.NotableFeatureDto;
import com.viewpharm.yakal.notablefeatures.dto.response.NotableFeatureStringDto;
import com.viewpharm.yakal.notablefeatures.repository.AllergyRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.base.type.EJob;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class AllergyService {
    private final AllergyRepository allergyRepository;
    private final UserRepository userRepository;

    public Boolean createAllergy(Long userId, NotableFeatureDto requestDto) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (requestDto.getNotableFeature().isEmpty())
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);

        allergyRepository.findByName(requestDto.getNotableFeature())
                .ifPresent(h -> {
                    throw new CommonException(ErrorCode.DUPLICATION_NOTABLE_FEATURE);
                });

        allergyRepository.save(Allergy.builder()
                .name(requestDto.getNotableFeature())
                .user(user)
                .build());

        return Boolean.TRUE;
    }

    public List<NotableFeatureStringDto> readAllergies(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<Allergy> allergies = allergyRepository.findAllByUserOrderByIdDesc(user);

        return allergies.stream()
                .map(allergy -> new NotableFeatureStringDto(allergy.getId(), allergy.getName()))
                .collect(Collectors.toList());
    }

    public Boolean deleteAllergies(Long userId, Long healthFoodId) {
        Allergy allergy = allergyRepository.findById(healthFoodId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_NOTABLE_FEATURE));

        if (allergy.getUser().getId() != userId)
            throw new CommonException(ErrorCode.NOT_EQUAL);

        allergyRepository.delete(allergy);

        return Boolean.TRUE;
    }

    public List<NotableFeatureStringDto> getHealthFoodListForExpert(Long expertId, Long patientId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //유저 확인
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<Allergy> allergies = allergyRepository.findAllByUserOrderByIdDesc(patient);

        return allergies.stream()
                .map(allergy -> new NotableFeatureStringDto(allergy.getId(), allergy.getName()))
                .collect(Collectors.toList());
    }
}
