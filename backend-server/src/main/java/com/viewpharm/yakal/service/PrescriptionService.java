package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Prescription;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.request.CreatePrescriptionDto;
import com.viewpharm.yakal.dto.response.PrescribedItemDto;
import com.viewpharm.yakal.dto.response.PrescriptionDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.PrescriptionRepository;
import com.viewpharm.yakal.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class PrescriptionService {

    private final UserRepository userRepository;
    private final PrescriptionRepository prescriptionRepository;

    public List<PrescriptionDto> getPrescriptions(Long userId){
        userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<Prescription> prescriptionList = prescriptionRepository.findByUserId(userId);
        List<PrescriptionDto> prescriptionDtoList =  prescriptionList.stream()
                .map(b-> new PrescriptionDto(b.getId(),b.getPharmacyName(),b.getPrescribedDate().toString(),b.getCreatedDate().toString()))
                .collect(Collectors.toList());

        return prescriptionDtoList;
    }

    public Boolean createPrescription(Long userId, CreatePrescriptionDto prescription){
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        prescriptionRepository.save(
                Prescription.builder()
                        .user(user)
                        .pharmacyName(prescription.getPharmacyName())
                        .prescribedDate(prescription.getPrescribedDate())
                        .isAllow(prescription.getIsAllow())
                        .build()
        );

        return true;
    }
}
