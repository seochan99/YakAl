package com.viewpharm.yakal.notablefeatures.service;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.notablefeatures.domain.Allergy;
import com.viewpharm.yakal.notablefeatures.domain.DietarySupplement;
import com.viewpharm.yakal.notablefeatures.dto.request.NotableFeatureRequestDto;
import com.viewpharm.yakal.notablefeatures.dto.response.NotableFeatureStringResponseDto;
import com.viewpharm.yakal.notablefeatures.repository.AllergyRepository;
import com.viewpharm.yakal.notablefeatures.repository.DietarySupplementRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.EJob;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.xmlbeans.impl.xb.xsdschema.All;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class AllergyService {
    private final AllergyRepository allergyRepository;
    private final UserRepository userRepository;

    public Boolean createAllergy(Long userId, NotableFeatureRequestDto requestDto) {
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

    public List<NotableFeatureStringResponseDto> readAllergies(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<Allergy> allergies = allergyRepository.findAllByUserOrderByIdDesc(user);

        return allergies.stream()
                .map(allergy -> new NotableFeatureStringResponseDto(allergy.getId(), allergy.getName()))
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

    //전문가가 환자의 건강 식품 리스트
    public List<NotableFeatureStringResponseDto> getHealthFoodListForExpert(Long expertId,Long patientId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //유저 확인
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<Allergy> allergies = allergyRepository.findAllByUserOrderByIdDesc(patient);

        return allergies.stream()
                .map(allergy -> new NotableFeatureStringResponseDto(allergy.getId(), allergy.getName()))
                .collect(Collectors.toList());
    }
}
