package com.viewpharm.yakal.medicalestablishment.service;

import com.viewpharm.yakal.base.dto.PageInfo;
import com.viewpharm.yakal.base.type.EMedical;
import com.viewpharm.yakal.base.utils.ImageUtil;
import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import com.viewpharm.yakal.medicalestablishment.domain.MedicalEstablishment;
import com.viewpharm.yakal.medicalestablishment.dto.request.MedicalEstablishmentDto;
import com.viewpharm.yakal.medicalestablishment.dto.request.MedicalEstablishmentForResisterDto;
import com.viewpharm.yakal.medicalestablishment.dto.response.MedicalEstablishmentAllDto;
import com.viewpharm.yakal.medicalestablishment.dto.response.MedicalEstablishmentDetailDto;
import com.viewpharm.yakal.medicalestablishment.dto.response.MedicalEstablishmentListDto;
import com.viewpharm.yakal.medicalestablishment.dto.response.MedicalEstablishmentListForAdminDto;
import com.viewpharm.yakal.medicalestablishment.repository.MedicalEstablishmentRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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

    public Map<String, Object> readMedicalEstablishments(EMedical eMedical, String searchWord, Integer page, Integer size) {
        // 페이지네이션
        PageRequest pageRequest = PageRequest.of(page, size, Sort.by("id").descending());

        // 의료기관 검색
        Page<MedicalEstablishment> medicalEstablishments;
        if (searchWord == null) {
            medicalEstablishments = medicalEstablishmentRepository.findList(eMedical, pageRequest);
        } else {
            medicalEstablishments = medicalEstablishmentRepository.findListBySearchWord(eMedical, searchWord, pageRequest);
        }

        // 의료기관 검색 결과
        PageInfo pageInfo = new PageInfo(page, size, (int) medicalEstablishments.getTotalElements(), medicalEstablishments.getTotalPages());

        List<MedicalEstablishmentListDto> list = medicalEstablishments.stream()
                .map(me -> new MedicalEstablishmentListDto(me.getId(), me.getName(), me.getAddress()))
                .toList();

        return Map.of("pageInfo", pageInfo, "dataList", list);
    }

    public MedicalEstablishmentAllDto getMedicalEstablishments(String name, String sorting, String ordering, Long pageIndex) {
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
                    Sort.by(order, "chief_name")
            );
            case "type" -> PageRequest.of(
                    pageIndex.intValue(),
                    PAGE_SIZE,
                    Sort.by(order, "type")
            );
            case "mname" -> PageRequest.of(
                    pageIndex.intValue(),
                    PAGE_SIZE,
                    Sort.by(order, "name")
            );
            default -> throw new CommonException(ErrorCode.INVALID_ARGUMENT);
        };

        Page<MedicalEstablishmentRepository.MedicalEstablishmentInfo> medicalEstablishmentList;

        if (name.isEmpty()) {
            medicalEstablishmentList = medicalEstablishmentRepository.findMedicalEstablishmentInfo(paging);
        } else {
            medicalEstablishmentList = medicalEstablishmentRepository.findMedicalEstablishmentInfoByName(name, paging);
        }

        PageInfo pageInfo = PageInfo.builder()
                .page(pageIndex.intValue())
                .size(PAGE_SIZE)
                .totalElements((int) medicalEstablishmentList.getTotalElements())
                .totalPages(medicalEstablishmentList.getTotalPages())
                .build();

        List<MedicalEstablishmentListForAdminDto> medicalEstablishmentListForAdminDtos = medicalEstablishmentList.stream()
                .map(m -> new MedicalEstablishmentListForAdminDto(m.getId(), m.getName(), m.getMedicalType().toString(), m.getChiefName(), m.getTel(), m.getDate()))
                .collect(Collectors.toList());


        return MedicalEstablishmentAllDto.builder()
                .datalist(medicalEstablishmentListForAdminDtos)
                .pageInfo(pageInfo)
                .build();
    }

    public MedicalEstablishmentDetailDto getMedicalEstablishmentDetail(Long medicalId) {
        MedicalEstablishment me = medicalEstablishmentRepository.findById(medicalId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_MEDICAL_ESTABLISHMENT));

        return new MedicalEstablishmentDetailDto(me.getType().toString(), me.getChiefName(), me.getChiefTel(), me.getName()
                , me.getEstablishmentNumber(), me.getZipCode(), me.getAddress(), me.getBusinessNumber(),
                me.getChiefLicenseImg(), me.getTel(), me.getClinicHours(), me.getFeatures(), me.getCreatedDate());
    }

    public Boolean approveMedicalEstablishment(MedicalEstablishmentForResisterDto request) {
        MedicalEstablishment me = medicalEstablishmentRepository.findById(request.getId())
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_MEDICAL_ESTABLISHMENT));
        //등록 승인
        me.updateIsRegister(request.getIsApproval());
        medicalEstablishmentRepository.flush();
        return Boolean.TRUE;
    }
}
