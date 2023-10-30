package com.viewpharm.yakal.service;


import com.viewpharm.yakal.domain.*;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.repository.*;
import com.viewpharm.yakal.base.type.EImageUseType;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Transactional
public class ImageService {
    private final UserRepository userRepository;
    private final MedicalRepository medicalRepository;
    private final ImageRepository imageRepository;
    private final ExpertRepository expertRepository;
    private final RegistrationRepository registrationRepository;

    private final String IMAGE_CONTENT_PREFIX = "image/";

    @Value("${spring.image.path}")
    private String FOLDER_PATH;

    public String uploadImage(Long useId, EImageUseType imageUseType, MultipartFile file) {
        final String contentType = file.getContentType();

        if (!contentType.startsWith(IMAGE_CONTENT_PREFIX)) {
            throw new CommonException(ErrorCode.NOT_IMAGE_ERROR);
        }

        // File Path Fetch
        String uuidImageName = UUID.randomUUID() + "." + contentType.substring(IMAGE_CONTENT_PREFIX.length());
        String filePath = FOLDER_PATH + uuidImageName;

        // File Upload
        try {
            file.transferTo(new File(filePath));
        } catch (Exception e) {
            throw new CommonException(ErrorCode.FILE_UPLOAD);
        }

        // Path DB Save
        Object useObject = null;
        switch (imageUseType) {
            case USER -> { useObject = userRepository.findById(useId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER)); }
            case MEDICAL -> { useObject = medicalRepository.findById(useId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_MEDICAL));}
            case REGISTER -> {useObject = registrationRepository.findById(useId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_MEDICAL));}
        }

        // Image Object find
        Image findImage = null;
        switch (imageUseType) {
            case USER -> { findImage = imageRepository.findByUser((User) useObject).orElseThrow(() -> new CommonException(ErrorCode.NOT_EXIST_ENTITY_REQUEST)); }
            case MEDICAL -> { findImage = imageRepository.findByMedical((Medical) useObject).orElseThrow(() -> new CommonException(ErrorCode.NOT_EXIST_ENTITY_REQUEST));}
            case REGISTER -> { findImage = imageRepository.findByRegistration((Registration) useObject).orElseThrow(() -> new CommonException(ErrorCode.NOT_EXIST_ENTITY_REQUEST));}
        }

        if (!findImage.getUuidName().equals("0_default_image.png")) {
            File currentFile = new File(findImage.getPath());
            boolean result = currentFile.delete();
        }

        findImage.updateImage(uuidImageName, file.getContentType(), filePath);

        return uuidImageName;
    }

    public Boolean uploadImages(Long useId, EImageUseType imageUseType, MultipartFile[] files) {
        Expert expert = expertRepository.findById(useId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
        List<Image> imageList = imageRepository.findByExpert(expert);
        for (int i=0; i< files.length;i++
             ) {
            final String contentType = files[i].getContentType();

            if (!contentType.startsWith(IMAGE_CONTENT_PREFIX)) {
                throw new CommonException(ErrorCode.NOT_IMAGE_ERROR);
            }

            // File Path Fetch
            String uuidImageName = UUID.randomUUID() + "." + contentType.substring(IMAGE_CONTENT_PREFIX.length());
            String filePath = FOLDER_PATH + uuidImageName;

            // File Upload
            try {
                files[i].transferTo(new File(filePath));
            } catch (Exception e) {
                throw new CommonException(ErrorCode.FILE_UPLOAD);
            }

            Image findImage = imageList.get(i);

            findImage.updateImage(uuidImageName, files[i].getContentType(), filePath);
        }


        return Boolean.TRUE;
    }

    /**
     * OCR이미지 업로드용
     * @param file
     * @return uuidImageName
     * @throws IOException
     */
    public String uploadImage(MultipartFile file) {
        // File Path Fetch
        String uuidImageName = UUID.randomUUID() + "_" + file.getOriginalFilename();
        String filePath = FOLDER_PATH + uuidImageName;

        // File Upload
        try {
            file.transferTo(new File(filePath));
        } catch (Exception e) {
            throw new CommonException(ErrorCode.FILE_UPLOAD);
        }
        return uuidImageName;
    }

    public byte[] downloadImage(String UuidName) throws IOException {
        String filePath = null;
        Image image = null;

        if (UuidName.equals("0_default_image.png")) {
            filePath = FOLDER_PATH + "0_default_image.png";
        } else {
            image = imageRepository.findByUuidName(UuidName).orElseThrow(() -> new CommonException(ErrorCode.FILE_DOWNLOAD));
            filePath = image.getPath();
        }

        byte[] images = Files.readAllBytes(new File(filePath).toPath());
        return images;
    }

    public Boolean removeImage(Image image){
        deleteImage(image.getPath());
        imageRepository.delete(image);
        return Boolean.TRUE;
    }

    public Boolean deleteImage(String path) {
        File currentFile = new File(path);
        return currentFile.delete();
    }

}