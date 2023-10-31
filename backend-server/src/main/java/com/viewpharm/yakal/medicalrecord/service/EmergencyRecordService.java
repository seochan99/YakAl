package com.viewpharm.yakal.medicalrecord.service;

import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.medicalrecord.domain.EmergencyRecord;
import com.viewpharm.yakal.medicalrecord.dto.reqeust.MedicalRecordDto;
import com.viewpharm.yakal.medicalrecord.dto.response.MedicalRecordStringDto;
import com.viewpharm.yakal.medicalrecord.repository.EmergencyRecordRepository;
import com.viewpharm.yakal.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class EmergencyRecordService {
    private final UserRepository userRepository;
    private final EmergencyRecordRepository emergencyRecordRepository;

    public Boolean createEmergencyRecord(Long id, MedicalRecordDto requestDto) {
        User user = userRepository.findById(id).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        emergencyRecordRepository.save(EmergencyRecord.builder()
                .user(user)
                .hospitalName(requestDto.getHospitalName())
                .date(requestDto.toSqlDate())
                .build());

        return Boolean.TRUE;
    }

    public List<MedicalRecordStringDto> readEmergencyRecords(Long id) {
        User user = userRepository.findById(id).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<EmergencyRecord> emergencyRecords = emergencyRecordRepository.findAllByUserOrderByDateDesc(user);

        return emergencyRecords.stream()
                .map(emergencyRecord -> new MedicalRecordStringDto(
                        emergencyRecord.getId(),
                        emergencyRecord.getHospitalName(),
                        emergencyRecord.getDate().toString()))
                .toList();
    }

    public Boolean deleteEmergencyRecord(Long id, Long emergencyRecordId) {
        EmergencyRecord emergencyRecord = emergencyRecordRepository.findById(emergencyRecordId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_MEDICAL_RECORD));

        if (!emergencyRecord.getUser().getId().equals(id)) {
            throw new CommonException(ErrorCode.NOT_EQUAL);
        }

        emergencyRecordRepository.delete(emergencyRecord);

        return Boolean.TRUE;
    }
}
