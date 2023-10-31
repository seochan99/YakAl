package com.viewpharm.yakal.medicalappointment.service;

import com.viewpharm.yakal.medicalappointment.domain.MedicalAppointment;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.response.*;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.repository.AnswerRepository;
import com.viewpharm.yakal.medicalappointment.repository.MedicalAppointmentRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.base.type.EJob;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class MedicalAppointmentService {
    private final UserRepository userRepository;
    private final MedicalAppointmentRepository medicalAppointmentRepository;
    private final AnswerRepository answerRepository;

    public Boolean createMedicalAppointment(Long expertId, Long patientId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //환자 확인
        User patient = userRepository.findByIdAndJob(patientId, EJob.PATIENT).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_PATIENT));

        //상담 중복 확인
        medicalAppointmentRepository.findByExpertAndPatient(expert, patient)
                .ifPresent(c -> {
                    throw new CommonException(ErrorCode.DUPLICATION_COUNSEL);
                });

        medicalAppointmentRepository.save(MedicalAppointment.builder()
                .expert(expert)
                .patient(patient)
                .build());

        return Boolean.TRUE;
    }

    public Boolean deleteMedicalAppointment(Long expertId, Long counselId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        MedicalAppointment medicalAppointment = medicalAppointmentRepository.findByIdAndIsDeleted(counselId, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_COUNSEL));

        //상담 전문가와 요청 전문가 비교
        if (medicalAppointment.getExpert().getId() != expert.getId())
            throw new CommonException(ErrorCode.NOT_EQUAL);

//        medicalAppointment.deleteCounsel();

        return Boolean.TRUE;
    }

    public PatientAllDto getPatientList(Long expertId, String sorting, String ordering, Long pageIndex, Long pageSize) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
        Sort.Direction order = Sort.Direction.ASC;
        Pageable paging = null;

        if (ordering.equals("desc"))
            order = Sort.Direction.DESC;

        if (sorting.equals("date"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(order, "lastModifiedDate"));
        else if (sorting.equals("name"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(order, "patient.name"));
        else if (sorting.equals("birth"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(order, "patient.birthday"));
        else throw new CommonException(ErrorCode.INVALID_ARGUMENT);

        Page<MedicalAppointment> counselList = medicalAppointmentRepository.findListByExpert(expert, paging);
        PageInfo pageInfo = new PageInfo(pageIndex.intValue(), pageSize.intValue(), (int) counselList.getTotalElements(), counselList.getTotalPages());

        List<PatientDto> patientDtoList = counselList.stream()
                .map(c -> new PatientDto(c.getPatient().getId(), c.getPatient().getName(), c.getPatient().getSex(), c.getPatient().getBirthday(), (int) (answerRepository.countAnswerByUser(c.getPatient()) * 100 / 14), answerRepository.findCreateDateByUser(c.getPatient()), c.getPatient().getTel()))
                .collect(Collectors.toList());

        return PatientAllDto.builder()
                .datalist(patientDtoList)
                .pageInfo(pageInfo)
                .build();
    }


    public PatientAllDto getPatientListByName(Long expertId, String name, String sorting, String ordering, Long pageIndex, Long pageSize) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
        Sort.Direction order = Sort.Direction.ASC;
        Pageable paging = null;

        if (ordering.equals("desc"))
            order = Sort.Direction.DESC;

        if (sorting.equals("date"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(order, "lastModifiedDate"));
        else if (sorting.equals("name"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(order, "patient.name"));
        else if (sorting.equals("birth"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(order, "patient.birthday"));
        else throw new CommonException(ErrorCode.INVALID_ARGUMENT);

        Page<MedicalAppointment> counselList = medicalAppointmentRepository.findListByExpertAndPatientName(expert, name, paging);
        PageInfo pageInfo = new PageInfo(pageIndex.intValue(), pageSize.intValue(), (int) counselList.getTotalElements(), counselList.getTotalPages());

        List<PatientDto> patientDtoList = counselList.stream()
                .map(c -> new PatientDto(c.getPatient().getId(), c.getPatient().getName(), c.getPatient().getSex(), c.getPatient().getBirthday(), (int) (answerRepository.countAnswerByUser(c.getPatient()) * 100 / 14), answerRepository.findCreateDateByUser(c.getPatient()), c.getPatient().getTel()))
                .collect(Collectors.toList());

        return PatientAllDto.builder()
                .datalist(patientDtoList)
                .pageInfo(pageInfo)
                .build();
    }
}
