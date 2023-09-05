package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.response.MedicalRegisterDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.service.ExpertService;
import com.viewpharm.yakal.service.ImageService;
import com.viewpharm.yakal.service.RegistrationService;
import com.viewpharm.yakal.type.EImageUseType;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/image")
@Tag(name = "Image", description = "이미지 업로드 및 다운로드")
public class ImageController {

    private final ImageService imageService;
    private final ExpertService expertService;

    @GetMapping("")
    @Operation(summary = "이미지 가져오기", description = "이미지 경로로 이미지 다운로드")
    public ResponseDto<Object> downloadImage(@RequestParam("uuid") String fileName) throws IOException {
        byte[] imageData = imageService.downloadImage(fileName);

        // 임시 체크
        if (imageData.length == 0)
            return ResponseDto.toResponseEntity(new CommonException(ErrorCode.FILE_DOWNLOAD));
        else
            return ResponseDto.ok(imageData);
    }

    @PostMapping("/user")
    public ResponseDto<Map<String,String>> uploadUserImage(@UserId Long id, @RequestParam("image") MultipartFile file){
        Map<String, String> map = new HashMap<>();
        map.put("uuid_name", imageService.uploadImage(id, EImageUseType.USER, file));
        return ResponseDto.ok(map);
    }

    @PostMapping("/expert")
    public ResponseDto<Boolean> uploadExpertImage(@UserId Long id, @RequestParam Long medicalId, @RequestParam("image") MultipartFile[] files){
        Long expertId = expertService.createExpert(id,medicalId,false);
        return ResponseDto.ok(imageService.uploadImages(expertId,EImageUseType.EXPERT,files));
    }

    //의료기관 등록용
    @PostMapping("/medical")
    public ResponseDto<Map<String,String>> uploadMedicalImage(@RequestParam("registerId") Long registerId, @RequestParam MultipartFile file){
        Map<String, String> map = new HashMap<>();
        map.put("uuid_name", imageService.uploadImage(registerId, EImageUseType. REGISTER, file));
        return ResponseDto.ok(map);
    }

    @PostMapping("/medical/{medicalId}")
    public ResponseDto<Map<String,String>> uploadShopImage(@PathVariable Long medicalId, @RequestParam("image") MultipartFile file){
        Map<String, String> map = new HashMap<>();
        map.put("uuid_name", imageService.uploadImage(medicalId, EImageUseType.MEDICAL, file));
        return ResponseDto.ok(map);
    }

    @PostMapping("/ocr")
    public ResponseDto<Map<String,String>> uploadAdvertisementImage(@RequestParam("image")MultipartFile file){
        Map<String, String> map = new HashMap<>();
        map.put("uuid_name", imageService.uploadImage(file));
        return ResponseDto.ok(map);
    }
}
