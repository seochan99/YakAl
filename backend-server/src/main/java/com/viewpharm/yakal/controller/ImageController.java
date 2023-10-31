package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.common.annotation.UserId;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.service.ExpertService;
import com.viewpharm.yakal.service.ImageService;
import com.viewpharm.yakal.base.type.EImageUseType;
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

    @PostMapping("/expert")
    public ResponseDto<Boolean> uploadExpertImage(@UserId Long id, @RequestParam Long medicalId, @RequestParam("image") MultipartFile[] files){
        Long expertId = expertService.createExpert(id,medicalId,false);
        return ResponseDto.ok(imageService.uploadImages(expertId,EImageUseType.EXPERT,files));
    }

    //의료기관 등록용
    @PostMapping("/medical")
    public ResponseDto<Map<String,String>> uploadMedicalImage(@RequestParam("registerId") Long registerId, @RequestParam("image") MultipartFile file){
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
}
