package com.viewpharm.yakal.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum ErrorCode {

    // Not Found Error
    NOT_FOUND_USER("4040", HttpStatus.NOT_FOUND, "해당 사용자가 존재하지 않습니다."),
    NOT_FOUND_COMMENT("4041", HttpStatus.NOT_FOUND, "Not Exist Comment"),
    NOT_FOUND_NOTIFICATION("4042", HttpStatus.NOT_FOUND, "Not Exist Notification"),
    NOT_FOUND_ADVERTISEMENT("4043", HttpStatus.NOT_FOUND, "Not Exist Advertisement"),
    NOT_FOUND_NOTICE("4044", HttpStatus.NOT_FOUND, "Not Exist Notice"),
    NOT_FOUND_DEVICE_TOKEN("4045", HttpStatus.NOT_FOUND, "Not Exist Device Token"),
    NOT_FOUND_DOSE("4046", HttpStatus.NOT_FOUND, "해당 복약 스케줄이 없습니다."),
    NOT_FOUND_PRESCRIPTION("4047", HttpStatus.NOT_FOUND, "해당 처방전이 존재하지 않습니다."),

    // Bad Request Error
    NOT_END_POINT("4000", HttpStatus.BAD_REQUEST, "Not Exist End Point Error"),
    NOT_EQUAL("4001", HttpStatus.BAD_REQUEST, "Not Equal Error"),
    DUPLICATION_TITLE("4002", HttpStatus.BAD_REQUEST, "Duplication Title"),
    DUPLICATION_NAME("4003", HttpStatus.BAD_REQUEST, "Duplication Name"),
    EXIST_ENTITY_REQUEST("4004", HttpStatus.BAD_REQUEST, "Exist Entity Request"),
    NOT_EXIST_ENTITY_REQUEST("4005", HttpStatus.BAD_REQUEST, "Not Exist Entity Request"),
    NOT_EXIST_PARAMETER("4006", HttpStatus.BAD_REQUEST, "Not Exist Parameter Request"),
    PAYMENT_FAIL("4007", HttpStatus.BAD_REQUEST, "InValid Payment Information Request"),
    INVALID_ARGUMENT("4008", HttpStatus.BAD_REQUEST, "Invalid Argument"),

    // Server, File Up/DownLoad Error
    SERVER_ERROR("5000", HttpStatus.INTERNAL_SERVER_ERROR, "Internal Server Error"),

    /**
     * 502 Bad Gateway: Gateway Server Error
     */
    AUTH_SERVER_USER_INFO_ERROR("5020", HttpStatus.BAD_GATEWAY, "Failed To Get User Info From Auth Server"),
    FILE_UPLOAD("5021", HttpStatus.BAD_GATEWAY, "File Upload Fail"),
    FILE_DOWNLOAD("5022", HttpStatus.BAD_GATEWAY, "File Download Fail"),
    SEND_NOTIFICATION_ERROR("5023", HttpStatus.BAD_GATEWAY, "Failed To Send Notification"),

    // Access Denied Error
    ACCESS_DENIED_ERROR("4010", HttpStatus.UNAUTHORIZED, "Access Denied Token Error"),

    /**
     * 401 Unauthorized: Authentication and Authorization Error
     */
    INVALID_TOKEN_ERROR("4011", HttpStatus.UNAUTHORIZED, "Invalid Token Error"),
    TOKEN_MALFORMED_ERROR("4012", HttpStatus.UNAUTHORIZED, "Malformed Token Error"),
    EXPIRED_TOKEN_ERROR("4013", HttpStatus.UNAUTHORIZED, "Expired Token Error"),
    TOKEN_TYPE_ERROR("4014", HttpStatus.UNAUTHORIZED, "Type Token Error"),
    TOKEN_UNSUPPORTED_ERROR("4015", HttpStatus.UNAUTHORIZED, "Unsupported Token Error"),
    TOKEN_GENERATION_ERROR("4016", HttpStatus.UNAUTHORIZED, "Failed To Generate Token"),
    TOKEN_UNKNOWN_ERROR("4018", HttpStatus.UNAUTHORIZED, "Unknown Error"),
    INSUFFICIENT_PRIVILEGES_ERROR("4019", HttpStatus.UNAUTHORIZED, "Insufficient Privileges Error");


    private final String code;
    private final HttpStatus httpStatus;
    private final String message;
}
