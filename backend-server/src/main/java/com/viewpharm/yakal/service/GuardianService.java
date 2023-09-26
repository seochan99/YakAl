package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Guardian;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.response.PatientDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.AnswerRepository;
import com.viewpharm.yakal.repository.GuardianRepository;
import com.viewpharm.yakal.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class GuardianService {
    private final GuardianRepository guardianRepository;
    private final UserRepository userRepository;
    private final AnswerRepository answerRepository;

    public Boolean createGuardian(Long guardianId, Long patientId) {
        User guardian = userRepository.findById(guardianId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        //보호자 환자 관계가 이미 있는지 확인
        guardianRepository.findByPatientAndGuardian(patient, guardian).ifPresent(g -> {
            throw new CommonException(ErrorCode.NOT_FOUND_GUARDIAN);
        });

        guardianRepository.save(Guardian.builder()
                .patient(patient)
                .guardian(guardian).build());

        return Boolean.TRUE;
    }

    //유저가 보호하고 있는 환자 찾기
    public PatientDto readPatient(Long guardianId) {
        //보호자 찾기
        User guardian = userRepository.findById(guardianId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        //보호자 관계 찾기
        Guardian guard = guardianRepository.findByGuardian(guardian).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_GUARDIAN));

        //보호자의 환자 찾기
        User patient = guard.getPatient();

        return PatientDto.builder()
                .id(patient.getId())
                .name(patient.getName())
                .sex(patient.getSex())
                .birthday(patient.getBirthday())
                .testProgress((int) (answerRepository.countAnswerByUser(patient) * 100 / 14))
                .lastSurbey(answerRepository.findCreateDateByUser(patient))
                .tel(patient.getTel()).build();
    }

    //유저의 보호자 찾기
    public PatientDto readGuardian(Long patientId) {
        //유저 찾기
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        //보호자 관계 찾기
        Guardian guard = guardianRepository.findByGuardian(patient).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_GUARDIAN));

        //유저의 보호자 찾기
        User guardian = guard.getPatient();

        return PatientDto.builder()
                .id(guardian.getId())
                .name(guardian.getName())
                .sex(guardian.getSex())
                .birthday(guardian.getBirthday())
                .testProgress((int) (answerRepository.countAnswerByUser(guardian) * 100 / 14))
                .lastSurbey(answerRepository.findCreateDateByUser(guardian))
                .tel(guardian.getTel()).build();
    }

    public Boolean deleteGuardian(Long guardianId, Long patientId) {
        User guardian = userRepository.findById(guardianId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Guardian guard = guardianRepository.findByPatientAndGuardian(patient, guardian).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_GUARDIAN));

        guardianRepository.delete(guard);

        return Boolean.TRUE;
    }

}
