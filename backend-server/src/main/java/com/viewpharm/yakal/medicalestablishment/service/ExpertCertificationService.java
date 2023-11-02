package com.viewpharm.yakal.medicalestablishment.service;

import com.viewpharm.yakal.base.type.EJob;
import com.viewpharm.yakal.base.utils.ImageUtil;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.medicalestablishment.domain.MedicalEstablishment;
import com.viewpharm.yakal.medicalestablishment.dto.request.ExpertCertificationDto;
import com.viewpharm.yakal.medicalestablishment.repository.ExpertCertificationRepository;
import com.viewpharm.yakal.medicalestablishment.repository.MedicalEstablishmentRepository;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExpertCertificationService {
    private final UserRepository userRepository;
    private final MedicalEstablishmentRepository medicalEstablishmentRepository;
    private final ExpertCertificationRepository expertCertificationRepository;
    private final ImageUtil imageUtil;

    public Boolean createExpertCertification(Long userId, ExpertCertificationDto requestDto,
                                             MultipartFile imgFile, MultipartFile affiliationImgFile) {
        User user = userRepository.findByIdAndJobOrJob(userId, EJob.DOCTOR, EJob.PHARMACIST)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        MedicalEstablishment medicalEstablishment = medicalEstablishmentRepository.findByIdAndIsRegister(requestDto.getFacilityId(), true)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_MEDICAL_ESTABLISHMENT));

        expertCertificationRepository.findByUserAndIsProcessed(user, Boolean.TRUE)
                .ifPresent(expertCertification -> {
                    throw new CommonException(ErrorCode.EXIST_EXPERT_CERTIFICATION);
                });

        expertCertificationRepository.findByUserAndMedicalEstablishmentAndIsProcessed(user, medicalEstablishment, Boolean.FALSE)
                .ifPresent(expertCertification -> {
                    throw new CommonException(ErrorCode.EXIST_EXPERT_CERTIFICATIONING);
                });

        String licenseImg = imageUtil.uploadImage(imgFile);
        String affiliationImg = imageUtil.uploadImage(affiliationImgFile);

        expertCertificationRepository.save(requestDto.toEntity(user, medicalEstablishment, licenseImg, affiliationImg));

        return Boolean.TRUE;
    }
}
