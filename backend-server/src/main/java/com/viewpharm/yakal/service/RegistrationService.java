package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Image;
import com.viewpharm.yakal.domain.Prescription;
import com.viewpharm.yakal.domain.Registration;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.request.CreatePrescriptionDto;
import com.viewpharm.yakal.dto.response.BoardListDto;
import com.viewpharm.yakal.dto.response.MedicalRegisterDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.ImageRepository;
import com.viewpharm.yakal.repository.RegistrationRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.EImageUseType;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class RegistrationService {

    private final RegistrationRepository registrationRepository;
    private final ImageRepository imageRepository;

    // @Value("${spring.image.path}")
    private final String FOLDER_PATH = "C:\\workspace\\YakAl\\backend-server\\src\\main\\resources";

    public Long createRegistration(MedicalRegisterDto medicalRegisterDto){

        Registration registration = Registration.builder()
                .eMedical(medicalRegisterDto.getMedicalType())
                .directorName(medicalRegisterDto.getDirectorName())
                .directorTel(medicalRegisterDto.getDirectorTel())
                .medicalName(medicalRegisterDto.getMedicalName())
                .medicalTel(medicalRegisterDto.getMedicalTel())
                .zipCode(medicalRegisterDto.getZipCode())
                .medicalAddress(medicalRegisterDto.getMedicalAddress())
                .medicalDetailAddress(medicalRegisterDto.getMedicalDetailAddress())
                .businessRegistrationNumber(medicalRegisterDto.getBusinessRegistrationNumber())
                .eRecive(medicalRegisterDto.getReciveType())
                .medicalRuntime(medicalRegisterDto.getMedicalRuntime())
                .medicalCharacteristics(medicalRegisterDto.getMedicalCharacteristics())
                .isPrecessed(Boolean.FALSE)
                .build();

        registration.setImage(
                imageRepository.save(
                        Image.builder()
                                .useObject(registration)
                                .imageUseType(EImageUseType.REGISTER)
                                .uuidName("0_default_image.png")
                                .type("image/png")
                                .path(FOLDER_PATH + "0_default_image.png").build()
                )
        );


        registrationRepository.save(registration);

        return registration.getId();
    }

    public List<MedicalRegisterDto> getMedicalRegisterList(Long page, Long num){
        Pageable pageable = PageRequest.of(page.intValue(), num.intValue());
        List<Registration> registrations = registrationRepository.getRegistrationByIsPrecessedFalse(pageable);
        List<MedicalRegisterDto> result = registrations.stream()
                .map(b -> new MedicalRegisterDto(b.getEMedical(),b.getDirectorName(),b.getDirectorTel(),
                        b.getMedicalName(),b.getMedicalTel(),b.getZipCode(),b.getMedicalAddress(),
                        b.getMedicalDetailAddress(),b.getBusinessRegistrationNumber(),b.getImage().getPath(),
                        b.getERecive(),b.getMedicalRuntime(),b.getMedicalCharacteristics()))
                .collect(Collectors.toList());
        return result;
    }

}
