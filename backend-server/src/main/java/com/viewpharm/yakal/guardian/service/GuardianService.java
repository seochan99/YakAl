package com.viewpharm.yakal.guardian.service;

import com.viewpharm.yakal.guardian.domain.Guardian;
import com.viewpharm.yakal.guardian.dto.response.GuardianTelDto;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.dto.response.PatientDto;
import com.viewpharm.yakal.guardian.dto.response.UserListDtoForGuardian;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.survey.repository.AnswerRepository;
import com.viewpharm.yakal.guardian.repository.GuardianRepository;
import com.viewpharm.yakal.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class GuardianService {
    private final GuardianRepository guardianRepository;
    private final UserRepository userRepository;
    private final AnswerRepository answerRepository;

    public Boolean createGuardian(Long userId, Long guardianId) {
        if (guardianId == userId) throw new CommonException(ErrorCode.EQUAL_GUARDIAN);

        User guardian = userRepository.findById(guardianId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        User patient = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        //보호자 환자 관계가 이미 있는지 확인 서로 한명씩만 있어야 함
        guardianRepository.findByPatientAndGuardian(patient, guardian).ifPresent(g -> {
            throw new CommonException(ErrorCode.DUPLICATION_GUARDIAN);
        });

        guardianRepository.save(Guardian.builder()
                .patient(patient)
                .guardian(guardian).build());

        return Boolean.TRUE;
    }

    public List<UserListDtoForGuardian> readGuardians(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        List<User> users = userRepository.searchGuardianForUser(user);


        return users.stream()
                .map(u -> UserListDtoForGuardian.builder().
                        id(u.getId())
                        .birthday(u.getBirthday().toString())
                        .name(u.getName()).build())
                .collect(Collectors.toList());
    }

    public GuardianTelDto readResentGuardian(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        Optional<User> resentGuardianOpt = userRepository.searchResentGuardianForUser(user);

        if (resentGuardianOpt.isEmpty())
            return GuardianTelDto.builder().build();
        else {
            User resentGuardian = resentGuardianOpt.get();

            return GuardianTelDto.builder()
                    .id(resentGuardian.getId())
                    .realName(resentGuardian.getRealName())
                    .tel(resentGuardian.getTel()).build();
        }
    }


    public Boolean deleteGuardian(Long userId, Long guardianId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        User guardian = userRepository.findById(guardianId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        Guardian guard = guardianRepository.findByPatientAndGuardian(user, guardian)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_GUARDIAN));

        guardianRepository.delete(guard);

        return Boolean.TRUE;
    }

    //유저가 보호하고 있는 환자 찾기
    @Deprecated
    public PatientDto readPatient(Long guardianId) {
        //보호자 찾기
        User guardian = userRepository.findById(guardianId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        //보호자 관계 찾기
        Guardian guard = guardianRepository.findFirstByGuardianOrderByCreatedDateDesc(guardian).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_GUARDIAN));

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
    @Deprecated
    public PatientDto readGuardian(Long patientId) {
        //유저 찾기
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        //보호자 관계 찾기
        Guardian guard = guardianRepository.findFirstByPatientOrderByCreatedDateDesc(patient).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_GUARDIAN));

        //유저의 보호자 찾기
        User guardian = guard.getGuardian();

        return PatientDto.builder()
                .id(guardian.getId())
                .name(guardian.getName())
                .sex(guardian.getSex())
                .birthday(guardian.getBirthday())
                .testProgress((int) (answerRepository.countAnswerByUser(guardian) * 100 / 14))
                .lastSurbey(answerRepository.findCreateDateByUser(guardian))
                .tel(guardian.getTel()).build();
    }
}
