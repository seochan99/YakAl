package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Diagnosis;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.request.DiagnosisRequestDto;
import com.viewpharm.yakal.dto.response.DiagnosisListDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.DiagnosisRepository;
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
public class DiagnosisService {
    private final DiagnosisRepository diagnosisRepository;
    private final UserRepository userRepository;

    //과거 병명 추가
    public Boolean createDiagnosis(Long userId, DiagnosisRequestDto requestDto) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        //중복 검사???

        if (requestDto.getName().length() == 0)
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);

        diagnosisRepository.save(Diagnosis.builder()
                .name(requestDto.getName())
                .user(user)
                .build());

        return Boolean.TRUE;
    }

    //read 없음

    //boolean 만 반환함
    public Boolean updateDiagnosis(Long userId, Long diagnosisId, DiagnosisRequestDto requestDto) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Diagnosis diagnosis = diagnosisRepository.findById(diagnosisId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_DIAGNOSIS));

        //전문가는 병명 못 고치도록 함
        if (diagnosis.getUser().getId() != userId)
            throw new CommonException(ErrorCode.NOT_EQUAL);

        if (requestDto.getName().length() == 0)
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);

        diagnosis.modifyDiagnosis(requestDto.getName());

        return Boolean.TRUE;
    }

    public Boolean deleteDiagnosis(Long userId, Long diagnosisId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Diagnosis diagnosis = diagnosisRepository.findById(diagnosisId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_DIAGNOSIS));

        //전문가는 못 삭제 하도록 함
        if (diagnosis.getUser().getId() != userId)
            throw new CommonException(ErrorCode.NOT_EQUAL);

        diagnosisRepository.delete(diagnosis);

        return Boolean.TRUE;
    }

    //자신의 과거 병명 리스트
    public List<DiagnosisListDto> getDiagnosisList(Long userId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<Diagnosis> diagnoses = diagnosisRepository.findAllByUser(user);

        List<DiagnosisListDto> listDtos = diagnoses.stream()
                .map(d -> new DiagnosisListDto(d.getId(), d.getName()))
                .collect(Collectors.toList());

        return listDtos;
    }

    //전문가가 환자의 과거 병명 리스트
    public List<DiagnosisListDto> getDiagnosisListForExpert(Long expertId,Long patientId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //유저 확인
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<Diagnosis> diagnoses = diagnosisRepository.findAllByUser(patient);

        List<DiagnosisListDto> listDtos = diagnoses.stream()
                .map(d -> new DiagnosisListDto(d.getId(), d.getName()))
                .collect(Collectors.toList());

        return listDtos;
    }
}
