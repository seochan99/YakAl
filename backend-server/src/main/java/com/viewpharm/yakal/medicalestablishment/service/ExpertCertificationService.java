package com.viewpharm.yakal.medicalestablishment.service;

import com.viewpharm.yakal.base.dto.PageInfo;
import com.viewpharm.yakal.base.utils.ImageUtil;
import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import com.viewpharm.yakal.medicalestablishment.domain.ExpertCertification;
import com.viewpharm.yakal.medicalestablishment.domain.MedicalEstablishment;
import com.viewpharm.yakal.medicalestablishment.dto.request.ExpertCertificationDto;
import com.viewpharm.yakal.medicalestablishment.dto.response.ExpertCertificationAllDto;
import com.viewpharm.yakal.medicalestablishment.dto.response.ExpertCertificationDetailDto;
import com.viewpharm.yakal.medicalestablishment.dto.response.ExpertCertificationListDto;
import com.viewpharm.yakal.medicalestablishment.dto.response.MedicalEstablishmentForExpertDto;
import com.viewpharm.yakal.medicalestablishment.repository.ExpertCertificationRepository;
import com.viewpharm.yakal.medicalestablishment.repository.MedicalEstablishmentRepository;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.user.dto.request.ExpertCertificationApproveDto;
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
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        MedicalEstablishment medicalEstablishment = medicalEstablishmentRepository.findByIdAndIsRegister(requestDto.getFacilityId(), true)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_MEDICAL_ESTABLISHMENT));

        expertCertificationRepository.findByUser(user)
                .ifPresent(expertCertification -> {
                    throw new CommonException(ErrorCode.EXIST_EXPERT_CERTIFICATION);
                });

        String licenseImg = imageUtil.uploadImage(imgFile);
        String affiliationImg = imageUtil.uploadImage(affiliationImgFile);

        expertCertificationRepository.save(requestDto.toEntity(user, medicalEstablishment, licenseImg, affiliationImg));

        return Boolean.TRUE;
    }

    // 전문가 신청 목록 조회
    public ExpertCertificationAllDto readProposalExpertCertifications(String name, String sorting, String ordering, Long pageIndex) {
        Sort.Direction order;

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

        if (name == null || name.isEmpty()) {
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
                .map(e -> new ExpertCertificationListDto(
                        e.getId(),
                        e.getName(),
                        e.getJob(),
                        e.getMedicalName(),
                        e.getTel(),
                        e.getDate()))
                .collect(Collectors.toList());

        return ExpertCertificationAllDto.builder()
                .datalist(expertCertificationListDtos)
                .pageInfo(pageInfo)
                .build();
    }

    // 전문가 신청 상세 조회
    public ExpertCertificationDetailDto readExpertCertificationDetail(Long expertCertificationId) {
        ExpertCertification ec = expertCertificationRepository.findExpertCertificationInfoById(expertCertificationId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT_CERTIFICATION));

        MedicalEstablishment me = ec.getMedicalEstablishment();
        if (me == null) throw new CommonException(ErrorCode.NOT_FOUND_MEDICAL_ESTABLISHMENT);

        MedicalEstablishmentForExpertDto medicalEstablishmentForExpertDto =
                new MedicalEstablishmentForExpertDto(
                        me.getType().toString(),
                        me.getChiefName(),
                        me.getChiefTel(),
                        me.getName(),
                        me.getEstablishmentNumber(),
                        me.getZipCode(),
                        me.getAddress(),
                        me.getBusinessNumber(),
                        me.getTel(),
                        me.getClinicHours(),
                        me.getFeatures());

        return new ExpertCertificationDetailDto(
                medicalEstablishmentForExpertDto,
                ec.getUser().getName(),
                ec.getUser().getTel(),
                ec.getCreatedDate(),
                ec.getType().toString(),
                ec.getLicenseImg(),
                ec.getAffiliationImg());
    }

    // 전문가 신청 승인/거부
    public Boolean updateExpertCertification(Long expertCertificationId, ExpertCertificationApproveDto approveDto) {
        ExpertCertification ec = expertCertificationRepository.findExpertCertificationInfoById(expertCertificationId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT_CERTIFICATION));

        // 등록 처리 완료
        ec.updateIsProcessed(approveDto.getIsApproval());
        expertCertificationRepository.flush();

        if (approveDto.getIsApproval()) {
            // 전문가 신청 승인/거부
            User expert = ec.getUser();
            expert.setRole(approveDto.getJob().toEole());
            expert.updateDepartment(approveDto.getDepartment());
            expert.setMedicalEstablishment(ec.getMedicalEstablishment());
            userRepository.flush();
        }

        return Boolean.TRUE;
    }
}
