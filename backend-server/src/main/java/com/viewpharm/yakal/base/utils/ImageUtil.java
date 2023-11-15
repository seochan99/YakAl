package com.viewpharm.yakal.base.utils;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.InputStream;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class ImageUtil {
    private final String IMAGE_CONTENT_PREFIX = "image/";
    private final AmazonS3 s3Client;

    @Value("${cloud.aws.s3.bucket}")
    private String BUCKET_PATH;


    public String uploadImage(MultipartFile file) {
        final String contentType = file.getContentType();

        assert contentType != null;
        if (!contentType.startsWith(IMAGE_CONTENT_PREFIX)) {
            throw new CommonException(ErrorCode.NOT_IMAGE_ERROR);
        }

        final String uuidImageName = UUID.randomUUID() + "." + contentType.split("/")[1];
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(file.getSize());
        metadata.setContentType(file.getContentType());

        try (final InputStream inputStream = file.getInputStream()) {
            String keyName = "profiles/" + uuidImageName;

            s3Client.putObject(
                    new PutObjectRequest(BUCKET_PATH, keyName, inputStream, metadata)
                            .withCannedAcl(CannedAccessControlList.PublicRead));
        } catch (Exception e) {
            throw new CommonException(ErrorCode.AWS_S3_ERROR);
        }

        return uuidImageName;
    }
}
