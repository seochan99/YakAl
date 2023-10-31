package com.viewpharm.yakal.medicalrecord.service;

import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.medicalrecord.domain.HospitalizationRecord;
import com.viewpharm.yakal.medicalrecord.dto.reqeust.MedicalRecordDto;
import com.viewpharm.yakal.medicalrecord.dto.response.MedicalRecordStringDto;
import com.viewpharm.yakal.medicalrecord.repository.HospitalizationRecordRepository;
import com.viewpharm.yakal.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class HospitalizationRecordService {
    private final UserRepository userRepository;
    private final HospitalizationRecordRepository hospitalizationRecordRepository;

    public Boolean createHospitalizationRecord(Long id, MedicalRecordDto requestDto) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        hospitalizationRecordRepository.save(HospitalizationRecord.builder()
                .user(user)
                .hospitalName(requestDto.getHospitalName())
                .date(requestDto.toSqlDate())
                .build());

        return Boolean.TRUE;
    }

    public List<MedicalRecordStringDto> readHospitalizationRecords(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<HospitalizationRecord> hospitalizationRecords = hospitalizationRecordRepository.findAllByUserOrderByDateDesc(user);

        return hospitalizationRecords.stream()
                .map(hospitalizationRecord -> new MedicalRecordStringDto(
                        hospitalizationRecord.getId(),
                        hospitalizationRecord.getHospitalName(),
                        hospitalizationRecord.getDate().toString()))
                .toList();
    }

    public Boolean deleteHospitalizationRecord(Long id, Long hospitalizationRecordId) {
        HospitalizationRecord hospitalizationRecord = hospitalizationRecordRepository.findById(hospitalizationRecordId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_MEDICAL_RECORD));

        if (!hospitalizationRecord.getUser().getId().equals(id)) {
            throw new CommonException(ErrorCode.NOT_EQUAL);
        }

        hospitalizationRecordRepository.delete(hospitalizationRecord);

        return Boolean.TRUE;
    }
}
