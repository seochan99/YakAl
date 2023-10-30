package com.viewpharm.yakal.notablefeatures.service;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.notablefeatures.domain.MedicalHistory;
import com.viewpharm.yakal.notablefeatures.domain.UnderlyingCondition;
import com.viewpharm.yakal.notablefeatures.dto.request.NotableFeatureRequestDto;
import com.viewpharm.yakal.notablefeatures.dto.response.NotableFeatureStringResponseDto;
import com.viewpharm.yakal.notablefeatures.repository.UnderlyingConditionRepository;
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
@RequiredArgsConstructor
public class UnderlyingConditionService {
    final private UnderlyingConditionRepository underlyingConditionRepository;
    final private UserRepository userRepository;

    public Boolean createUnderlyingCondition(Long userId, NotableFeatureRequestDto requestDto) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (requestDto.getNotableFeature().isEmpty())
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);

        // 기존에 존재하는지 확인
        underlyingConditionRepository.findByName(requestDto.getNotableFeature())
                .ifPresent(u -> {
                    throw new CommonException(ErrorCode.DUPLICATION_NOTABLE_FEATURE);
                });

        underlyingConditionRepository.save(UnderlyingCondition.builder()
                .name(requestDto.getNotableFeature())
                .user(user)
                .build());

        return Boolean.TRUE;
    }

    public List<NotableFeatureStringResponseDto> readUnderlyingConditions(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<UnderlyingCondition> underlyingConditions = underlyingConditionRepository.findAllByUserOrderByIdDesc(user);

        return underlyingConditions.stream()
                .map(underlyingCondition -> new NotableFeatureStringResponseDto(underlyingCondition.getId(), underlyingCondition.getName()))
                .collect(Collectors.toList());
    }

    public Boolean deleteUnderlyingCondition(Long userId, Long underlyingConditionId) {
        UnderlyingCondition underlyingCondition = underlyingConditionRepository.findById(underlyingConditionId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_NOTABLE_FEATURE));

        if (underlyingCondition.getUser().getId() != userId)
            throw new CommonException(ErrorCode.NOT_EQUAL);

        underlyingConditionRepository.delete(underlyingCondition);

        return Boolean.TRUE;
    }

    //전문가가 환자의 과거 병명 리스트
    public List<NotableFeatureStringResponseDto> readUnderlyingConditions(Long expertId, Long patientId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //유저 확인
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<UnderlyingCondition> underlyingConditions = underlyingConditionRepository.findAllByUserOrderByIdDesc(patient);

        return underlyingConditions.stream()
                .map(UnderlyingCondition -> new NotableFeatureStringResponseDto(UnderlyingCondition.getId(), UnderlyingCondition.getName()))
                .collect(Collectors.toList());
    }
}
