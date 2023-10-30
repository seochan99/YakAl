package com.viewpharm.yakal.notablefeatures.service;

import com.viewpharm.yakal.notablefeatures.domain.MedicalHistory;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.notablefeatures.dto.request.NotableFeatureRequestDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.notablefeatures.dto.response.NotableFeatureStringResponseDto;
import com.viewpharm.yakal.notablefeatures.repository.MedicalHistoryRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.EJob;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class MedicalHistoryService {
    private final MedicalHistoryRepository medicalHistoryRepository;
    private final UserRepository userRepository;

    public Boolean createMedicalHistory(Long userId, NotableFeatureRequestDto requestDto) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (requestDto.getNotableFeature().isEmpty())
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);

        medicalHistoryRepository.save(MedicalHistory.builder()
                .name(requestDto.getNotableFeature())
                .user(user)
                .build());

        return Boolean.TRUE;
    }

    public List<NotableFeatureStringResponseDto> readMedicalHistories(Long userId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<MedicalHistory> medicalHistories = medicalHistoryRepository.findAllByUserOrderByIdDesc(user);

        return medicalHistories.stream()
                .map(medicalHistory -> new NotableFeatureStringResponseDto(medicalHistory.getId(), medicalHistory.getName()))
                .collect(Collectors.toList());
    }

    public Boolean deleteMedicalHistory(Long userId, Long diagnosisId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        MedicalHistory diagnosis = medicalHistoryRepository.findById(diagnosisId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_NOTABLE_FEATURE));

        //전문가는 못 삭제 하도록 함
        if (diagnosis.getUser().getId() != userId)
            throw new CommonException(ErrorCode.NOT_EQUAL);

        medicalHistoryRepository.delete(diagnosis);

        return Boolean.TRUE;
    }

    //전문가가 환자의 과거 병명 리스트
    public List<NotableFeatureStringResponseDto> getDiagnosisListForExpert(Long expertId, Long patientId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //유저 확인
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<MedicalHistory> diagnoses = medicalHistoryRepository.findAllByUserOrderByIdDesc(patient);

        return diagnoses.stream()
                .map(d -> new NotableFeatureStringResponseDto(d.getId(), d.getName()))
                .collect(Collectors.toList());
    }
}
