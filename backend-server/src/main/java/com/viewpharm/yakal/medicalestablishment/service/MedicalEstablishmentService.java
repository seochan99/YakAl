package com.viewpharm.yakal.medicalestablishment.service;

import com.viewpharm.yakal.base.utils.ImageUtil;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.medicalestablishment.dto.request.MedicalEstablishmentDto;
import com.viewpharm.yakal.medicalestablishment.repository.MedicalEstablishmentRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@Service
@RequiredArgsConstructor
public class MedicalEstablishmentService {
    private final MedicalEstablishmentRepository medicalEstablishmentRepository;
    private final ImageUtil imageUtil;

    public Boolean createMedicalEstablishment(MedicalEstablishmentDto requestDto, MultipartFile imgFile) {
        // 이미 등록된 의료기관인지 확인
        medicalEstablishmentRepository.findByEstablishmentNumberAndIsRegister(requestDto.getFacilityNumber(), Boolean.TRUE)
                .ifPresent(medicalEstablishment -> {
                    throw new CommonException(ErrorCode.DUPLICATION_MEDICAL_ESTABLISHMENT);
                });

        // 이미지 업로드
        String uuidImageName = imageUtil.uploadImage(imgFile);

        // 의료기관 등록
        medicalEstablishmentRepository.save(requestDto.toEntity(uuidImageName));

        return Boolean.TRUE;
    }
}
