package com.viewpharm.yakal.base.utils;

import com.viewpharm.yakal.base.type.EImageUseType;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.domain.Image;
import com.viewpharm.yakal.domain.Medical;
import com.viewpharm.yakal.domain.Registration;
import com.viewpharm.yakal.user.domain.User;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class ImageUtil {
    private final String IMAGE_CONTENT_PREFIX = "image/";

    @Value("${spring.image.path}")
    private String FOLDER_PATH;

    public String uploadImage( MultipartFile file) {
        final String contentType = file.getContentType();

        if (!contentType.startsWith(IMAGE_CONTENT_PREFIX)) {
            throw new CommonException(ErrorCode.NOT_IMAGE_ERROR);
        }


        // File Path Fetch
        // uuidImageName은 파일 이름을 랜덤으로 생성하여 중복을 방지한다. 또한, 확장자는 contentType에서 가져온다.
        final String uuidImageName = UUID.randomUUID().toString() + "." + contentType.split("/")[1];
        String filePath = FOLDER_PATH + uuidImageName;

        // File Upload
        try {
            file.transferTo(new File(filePath));
        } catch (Exception e) {
            throw new CommonException(ErrorCode.FILE_UPLOAD);
        }

        return uuidImageName;
    }
}
