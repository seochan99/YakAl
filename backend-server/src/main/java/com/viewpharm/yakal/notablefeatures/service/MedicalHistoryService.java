package com.viewpharm.yakal.notablefeatures.service;

import com.viewpharm.yakal.notablefeatures.domain.MedicalHistory;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.notablefeatures.dto.request.NotableFeatureRequestDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.notablefeatures.dto.response.NotableFeatureStringResponseDto;
import com.viewpharm.yakal.repository.DiagnosisRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.EJob;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

//기저 질환 및 알러지으로 변경 예정
@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class MedicalHistoryService {
    private final DiagnosisRepository diagnosisRepository;
    private final UserRepository userRepository;

    //과거 병명 추가
    public Boolean createDiagnosis(Long userId, NotableFeatureRequestDto requestDto) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        //중복 검사???

        if (requestDto.getNotableFeature().isEmpty())
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);

        diagnosisRepository.save(MedicalHistory.builder()
                .name(requestDto.getNotableFeature())
                .user(user)
                .build());

        return Boolean.TRUE;
    }

    //read 없음

    //boolean 만 반환함
    public Boolean updateDiagnosis(Long userId, Long diagnosisId, NotableFeatureRequestDto requestDto) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        MedicalHistory diagnosis = diagnosisRepository.findById(diagnosisId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_DIAGNOSIS));

        //전문가는 병명 못 고치도록 함
        if (diagnosis.getUser().getId() != userId)
            throw new CommonException(ErrorCode.NOT_EQUAL);

        if (requestDto.getNotableFeature().isEmpty())
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);

        diagnosis.modifyDiagnosis(requestDto.getNotableFeature());

        return Boolean.TRUE;
    }

    public Boolean deleteDiagnosis(Long userId, Long diagnosisId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        MedicalHistory diagnosis = diagnosisRepository.findById(diagnosisId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_DIAGNOSIS));

        //전문가는 못 삭제 하도록 함
        if (diagnosis.getUser().getId() != userId)
            throw new CommonException(ErrorCode.NOT_EQUAL);

        diagnosisRepository.delete(diagnosis);

        return Boolean.TRUE;
    }

    //자신의 과거 병명 리스트
    public List<NotableFeatureStringResponseDto> getDiagnosisList(Long userId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<MedicalHistory> diagnoses = diagnosisRepository.findAllByUser(user);

        List<NotableFeatureStringResponseDto> result = diagnoses.stream()
                .map(d -> new NotableFeatureStringResponseDto(d.getId(), d.getName()))
                .collect(Collectors.toList());

        return result;
    }

    //전문가가 환자의 과거 병명 리스트
    public List<NotableFeatureStringResponseDto> getDiagnosisListForExpert(Long expertId, Long patientId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //유저 확인
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<MedicalHistory> diagnoses = diagnosisRepository.findAllByUser(patient);

        List<NotableFeatureStringResponseDto> result = diagnoses.stream()
                .map(d -> new NotableFeatureStringResponseDto(d.getId(), d.getName()))
                .collect(Collectors.toList());

        return result;
    }
}
