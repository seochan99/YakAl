package com.viewpharm.yakal.medicalestablishment.service;

import com.viewpharm.yakal.base.dto.PageInfo;
import com.viewpharm.yakal.base.type.EJob;
import com.viewpharm.yakal.base.utils.ImageUtil;
import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import com.viewpharm.yakal.medicalestablishment.domain.ExpertCertification;
import com.viewpharm.yakal.medicalestablishment.domain.MedicalEstablishment;
import com.viewpharm.yakal.medicalestablishment.dto.request.ExpertCertificationDto;
import com.viewpharm.yakal.medicalestablishment.dto.request.ExpertCertificationForResisterDto;
import com.viewpharm.yakal.medicalestablishment.dto.response.ExpertCertificationAllDto;
import com.viewpharm.yakal.medicalestablishment.dto.response.ExpertCertificationListDto;
import com.viewpharm.yakal.medicalestablishment.repository.ExpertCertificationRepository;
import com.viewpharm.yakal.medicalestablishment.repository.MedicalEstablishmentRepository;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.stream.Collectors;

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
//        User user = userRepository.findByIdAndJobOrJob(userId, EJob.DOCTOR, EJob.PHARMACIST)
//                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
//
//        MedicalEstablishment medicalEstablishment = medicalEstablishmentRepository.findByIdAndIsRegister(requestDto.getFacilityId(), true)
//                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_MEDICAL_ESTABLISHMENT));
//
//        expertCertificationRepository.findByUserAndIsProcessed(user, Boolean.TRUE)
//                .ifPresent(expertCertification -> {
//                    throw new CommonException(ErrorCode.EXIST_EXPERT_CERTIFICATION);
//                });
//
//        expertCertificationRepository.findByUserAndMedicalEstablishmentAndIsProcessed(user, medicalEstablishment, Boolean.FALSE)
//                .ifPresent(expertCertification -> {
//                    throw new CommonException(ErrorCode.EXIST_EXPERT_CERTIFICATIONING);
//                });
//
//        String licenseImg = imageUtil.uploadImage(imgFile);
//        String affiliationImg = imageUtil.uploadImage(affiliationImgFile);
//
//        expertCertificationRepository.save(requestDto.toEntity(user, medicalEstablishment, licenseImg, affiliationImg));

        return Boolean.TRUE;
    }

    //전문가 신청 내역 조회
    public ExpertCertificationAllDto getExpertCertification(String name, String sorting, String ordering, Long pageIndex) {
        Sort.Direction order;
        log.info(ordering.toString());
        if (ordering.equals("desc")) {
            order = Sort.Direction.DESC;
        } else {
            order = Sort.Direction.ASC;
        }
        final int PAGE_SIZE = 10;

        final Pageable paging = switch (sorting) {
            case "date" -> PageRequest.of(
                    pageIndex.intValue(),
                    PAGE_SIZE,
                    Sort.by(order, "created_at")
            );
            case "name" -> PageRequest.of(
                    pageIndex.intValue(),
                    PAGE_SIZE,
                    Sort.by(order, "NAME")
            );
            case "medical" -> PageRequest.of(
                    pageIndex.intValue(),
                    PAGE_SIZE,
                    Sort.by(order, "MEDICALNAME")
            );
            default -> throw new CommonException(ErrorCode.INVALID_ARGUMENT);
        };

        Page<ExpertCertificationRepository.ExpertCertificationInfo> expertCertificationList;

        if (name.isEmpty()) {
            expertCertificationList = expertCertificationRepository.findExpertCertificationInfo(paging);
        } else {
            expertCertificationList = expertCertificationRepository.findExpertCertificationInfoByName(name, paging);
        }

        PageInfo pageInfo = PageInfo.builder()
                .page(pageIndex.intValue())
                .size(PAGE_SIZE)
                .totalElements((int) expertCertificationList.getTotalElements())
                .totalPages(expertCertificationList.getTotalPages())
                .build();

        List<ExpertCertificationListDto> expertCertificationListDtos = expertCertificationList.stream()
                .map(e -> new ExpertCertificationListDto(e.getId(), e.getName(), e.getJob(), e.getMedicalName(), e.getTel(), e.getDate()))
                .collect(Collectors.toList());

        return ExpertCertificationAllDto.builder()
                .datalist(expertCertificationListDtos)
                .pageInfo(pageInfo)
                .build();
    }

    public Boolean approveExpertCertification(ExpertCertificationForResisterDto request) {
        ExpertCertification ec = expertCertificationRepository.findById(request.getId())
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
        //등록 승인
        ec.updateIsProcessed(request.getIsApproval());
        expertCertificationRepository.flush();
        return Boolean.TRUE;
    }
}
