package com.viewpharm.yakal.medicalappointment.service;

import com.viewpharm.yakal.base.dto.PageInfo;
import com.viewpharm.yakal.medicalappointment.domain.MedicalAppointment;
import com.viewpharm.yakal.medicalappointment.dto.MedicalAppointmentListDto;
import com.viewpharm.yakal.medicalappointment.dto.PatientBaseInfoDto;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import com.viewpharm.yakal.survey.repository.AnswerRepository;
import com.viewpharm.yakal.medicalappointment.repository.MedicalAppointmentRepository;
import com.viewpharm.yakal.user.dto.response.PatientAllDto;
import com.viewpharm.yakal.user.dto.response.PatientDto;
import com.viewpharm.yakal.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class MedicalAppointmentService {
    private final UserRepository userRepository;
    private final MedicalAppointmentRepository medicalAppointmentRepository;
    private final AnswerRepository answerRepository;

    public Boolean createMedicalAppointment(Long userId, Long expertId) {
        //환자 확인
        User patient = userRepository.findById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_PATIENT));

        //전문가 확인
        User expert = userRepository.findExpertById(expertId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //상담 중복 확인
        medicalAppointmentRepository.findByExpertAndPatient(expert, patient)
                .ifPresent(c -> {
                    throw new CommonException(ErrorCode.DUPLICATION_MEDICAL_APPOINTMENT);
                });

        medicalAppointmentRepository.save(MedicalAppointment.builder()
                .expert(expert)
                .patient(patient)
                .build());

        return Boolean.TRUE;
    }

    public List<MedicalAppointmentListDto> readMedicalAppointments(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_PATIENT));

        List<MedicalAppointment> medicalAppointments = medicalAppointmentRepository.findExpertForPatient(user);

        return medicalAppointments.stream()
                .map(medicalAppointment -> MedicalAppointmentListDto.builder()
                        .id(medicalAppointment.getExpert().getId())
                        .name(medicalAppointment.getExpert().getName())
                        .medicalEstablishmentName(medicalAppointment.getExpert().getMedicalEstablishment().getName())
                        .sharedDate(medicalAppointment.getCreateDate().toString())
                        .build())
                .collect(Collectors.toList());
    }

    public Boolean deleteMedicalAppointment(Long userId, Long expertId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_PATIENT));
        //전문가 확인
        User expert = userRepository.findExpertById(expertId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        MedicalAppointment medicalAppointment = medicalAppointmentRepository.findByExpertAndPatient(expert, user)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_MEDICAL_APPOINTMENT));

        // 해당 유저가 만든 공유가 아니 경우
        if (!Objects.equals(medicalAppointment.getPatient().getId(), user.getId()))
            throw new CommonException(ErrorCode.NOT_EQUAL);

        medicalAppointmentRepository.delete(medicalAppointment);

        return Boolean.TRUE;
    }

    public PatientAllDto getPatientList(Long expertId, String name, String sorting, String ordering, Long pageIndex, Long pageSize, Boolean onlyFavorite) {
        final User expert = userRepository.findExpertById(expertId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        Sort.Direction order;

        if (ordering.equals("desc")) {
            order = Sort.Direction.DESC;
        } else {
            order = Sort.Direction.ASC;
        }

        final Pageable paging = switch (sorting) {
            case "date" -> PageRequest.of(
                    pageIndex.intValue(),
                    pageSize.intValue(),
                    Sort.by(
                            Sort.Order.by("lastModifiedDate").with(order),
                            Sort.Order.by("patient.name").with(order)
                    )
            );
            case "name" -> PageRequest.of(
                    pageIndex.intValue(),
                    pageSize.intValue(),
                    Sort.by(
                            Sort.Order.by("patient.name").with(order),
                            Sort.Order.by("lastModifiedDate").with(order)
                    )
            );
            case "birth" -> PageRequest.of(
                    pageIndex.intValue(),
                    pageSize.intValue(),
                    Sort.by(
                            Sort.Order.by("patient.birthday").with(order),
                            Sort.Order.by("lastModifiedDate").with(order)
                    )
            );
            default -> throw new CommonException(ErrorCode.INVALID_ARGUMENT);
        };

        Page<MedicalAppointment> counselList;

        if (name.isEmpty()) {
            if (onlyFavorite) {
                counselList = medicalAppointmentRepository.findListByExpertAndIsFavorite(expert, paging);
            } else {
                counselList = medicalAppointmentRepository.findListByExpert(expert, paging);
            }
        } else {
            if (onlyFavorite) {
                counselList = medicalAppointmentRepository.findListByExpertAndIsFavoriteAndName(expert, name, paging);
            } else {
                counselList = medicalAppointmentRepository.findListByExpertAndName(expert, name, paging);
            }
        }

        final PageInfo pageInfo = PageInfo.builder()
                .page(pageIndex.intValue())
                .size(pageSize.intValue())
                .totalElements((int) counselList.getTotalElements())
                .totalPages(counselList.getTotalPages())
                .build();

        final List<PatientDto> patientDtoList = counselList.stream()
                .map(c -> PatientDto.builder()
                        .id(c.getPatient().getId())
                        .name(c.getPatient().getName())
                        .sex(c.getPatient().getSex())
                        .birthday( c.getPatient().getBirthday())
                        .lastQuestionnaireDate(answerRepository.findCreateDateByUser(c.getPatient()))
                        .tel(c.getPatient().getTel())
                        .isFavorite(c.getIsFavorite())
                        .build())
                .collect(Collectors.toList());

        return PatientAllDto.builder()
                .datalist(patientDtoList)
                .pageInfo(pageInfo)
                .build();
    }

    public void updateIsFavorite(Long expertId, Long patientId) {
        final User expert = userRepository.findExpertById(expertId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
        final User patient = userRepository.findById(patientId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        final MedicalAppointment medicalAppointment = medicalAppointmentRepository.findByExpertAndPatientAndIsDeleted(expert, patient, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_MEDICAL_APPOINTMENT));

        medicalAppointment.updateIsFavorite(!medicalAppointment.getIsFavorite());
    }

    public PatientBaseInfoDto readPatientBaseInfo(final Long expertId, final Long patientId) {
        final User expert = userRepository.findExpertById(expertId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
        final User patient = userRepository.findById(patientId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        medicalAppointmentRepository.findByExpertAndPatientAndIsDeleted(expert, patient, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_MEDICAL_APPOINTMENT));

        return PatientBaseInfoDto.builder()
                .name(patient.getName())
                .birthday(patient.getBirthday())
                .tel(patient.getTel())
                .build();
    }
}
