package com.viewpharm.yakal.medicalestablishment.service;

import com.viewpharm.yakal.base.PageInfo;
import com.viewpharm.yakal.base.type.EMedical;
import com.viewpharm.yakal.base.utils.ImageUtil;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.medicalestablishment.domain.MedicalEstablishment;
import com.viewpharm.yakal.medicalestablishment.dto.request.MedicalEstablishmentDto;
import com.viewpharm.yakal.medicalestablishment.dto.response.MedicalEstablishmentListDto;
import com.viewpharm.yakal.medicalestablishment.repository.MedicalEstablishmentRepository;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.awt.print.Pageable;
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
        Page< MedicalEstablishment> medicalEstablishments = medicalEstablishmentRepository.findListBySearchWord(eMedical, searchWord, pageRequest);

        // 의료기관 검색 결과
        PageInfo pageInfo = new PageInfo(page, size, (int) medicalEstablishments.getTotalElements(), medicalEstablishments.getTotalPages());

        List<MedicalEstablishmentListDto> list = medicalEstablishments.stream()
                .map(me -> new MedicalEstablishmentListDto(me.getId(), me.getName(), me.getAddress()))
                .collect(Collectors.toList());

        return Map.of("pageInfo", pageInfo, "dataList", list);
    }
}
