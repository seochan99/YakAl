package com.viewpharm.yakal.user.service;

import com.viewpharm.yakal.medicalappointment.repository.MedicalAppointmentRepository;
import com.viewpharm.yakal.user.domain.Expert;
import com.viewpharm.yakal.domain.Image;
import com.viewpharm.yakal.domain.Medical;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.dto.request.UpdateAdminRequestDto;
import com.viewpharm.yakal.dto.response.ExpertRegisterDto;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.user.repository.ExpertRepository;
import com.viewpharm.yakal.repository.ImageRepository;
import com.viewpharm.yakal.repository.MedicalRepository;
import com.viewpharm.yakal.user.repository.UserRepository;
import com.viewpharm.yakal.base.type.EImageUseType;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class ExpertService {

    private final ExpertRepository expertRepository;
    private final UserRepository userRepository;
    private final ImageRepository imageRepository;
    private final MedicalRepository medicalRepository;
    private final MedicalAppointmentRepository medicalAppointmentRepository;

    @Value("${spring.image.path}")
    private String FOLDER_PATH;

    public Long createExpert(final Long userId,final Long medicalId,Boolean type){
        final User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        final Medical medical = medicalRepository.findById(medicalId).orElseThrow(()-> new CommonException(ErrorCode.NOT_FOUND_MEDICAL));

        // Expert 가 이미 존재하는 경우
        if(user.getExpert() != null)
            return user.getExpert().getId();


        Expert expert = new Expert(user);

        List<Image> imageList = new ArrayList<>();
        imageList.add(imageRepository.save(
                Image.builder()
                        .useObject(expert)
                        .imageUseType(EImageUseType.EXPERT)
                        .uuidName("0_default_image.png")
                        .type("image/png")
                        .path(FOLDER_PATH + "0_default_image.png").build()));
        imageList.add(imageRepository.save(
                Image.builder()
                        .useObject(expert)
                        .imageUseType(EImageUseType.EXPERT)
                        .uuidName("0_default_image.png")
                        .type("image/png")
                        .path(FOLDER_PATH + "0_default_image.png").build()));
        expert.setImages(imageList);

        expert.setMedical(medical);
        user.setExpert(expert);

        expertRepository.save(expert);

        return expert.getId();
    }

    public List<ExpertRegisterDto> getExpertRegisterList(Long pageIndex, Long pageSize){
        Pageable pageable = PageRequest.of(pageIndex.intValue(), pageSize.intValue());
        // 전문가 처리 안된 등록 불러오기
        List<Expert> experts = expertRepository.findExpertByIsProcessed(false,pageable);

        //Dto 변환
        List<ExpertRegisterDto> registerDtoList = experts.stream()
                .map(b -> new ExpertRegisterDto(b.getMedical().getId(),b.getUser().getName(),b.getUser().getBirthday()
                ,b.getImages().get(0).getPath(),b.getImages().get(1).getPath(),b.getCreateDate()))
                .collect(Collectors.toList());

        return registerDtoList;
    }

    public Boolean updateMedicalRegister(final Long id, final UpdateAdminRequestDto updateAdminRequestDto){
        Boolean isAllow = updateAdminRequestDto.getIsAllow();
        if(!isAllow)
            return Boolean.TRUE;

        User user = userRepository.findById(id).orElseThrow(()-> new CommonException(ErrorCode.NOT_FOUND_USER));
        Expert expert = expertRepository.findByUser(user).orElseThrow(()-> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        // 전문가 업데이트
        expert.setIsProcessed(isAllow);
        expert.getMedical().setRegister(isAllow);
        expert.getUser().setIsCertified(isAllow);
        expert.getUser().setJob(updateAdminRequestDto.getJob());

        // 이미지 삭제 처리 로직은 구현 안함
        return Boolean.TRUE;
    }

//    public Boolean updateIsFavorite(Long expertId, Boolean)
}
