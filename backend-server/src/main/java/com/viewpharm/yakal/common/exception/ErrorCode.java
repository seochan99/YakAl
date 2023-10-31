package com.viewpharm.yakal.common.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum ErrorCode {
    // Not Found Error
    NOT_FOUND_USER("4040", HttpStatus.NOT_FOUND, "해당 사용자가 존재하지 않습니다."),
    NOT_FOUND_DEVICE_TOKEN("4045", HttpStatus.NOT_FOUND, "디바이스 토큰이 존재하지 않습니다."),
    NOT_FOUND_DOSE("4046", HttpStatus.NOT_FOUND, "해당 복약 스케줄이 없습니다."),
    NOT_FOUND_PRESCRIPTION("4047", HttpStatus.NOT_FOUND, "해당 처방전이 존재하지 않습니다."),
    NOT_FOUND_RISK("4048", HttpStatus.NOT_FOUND, "해당 위험도 정보가 없습니다."),
    NOT_FOUND_MEDICAL("4049", HttpStatus.NOT_FOUND, "해당 의료기관이 존재하지 않습니다"),
    NOT_FOUND_BOARD("4050", HttpStatus.NOT_FOUND, "해당 게시글이 존재하지 않습니다."),
    NOT_FOUND_EXPERT("4051", HttpStatus.NOT_FOUND, "해당 전문가는 존재하지 않습니다."),
    NOT_FOUND_PATIENT("4052", HttpStatus.NOT_FOUND, "해당 환자가 존재하지 않습니다."),
    NOT_FOUND_MEDICAL_APPOINTMENT("4053", HttpStatus.NOT_FOUND, "해당 공유가 존재하지 않습니다."),
    NOT_FOUND_NOTE("4054", HttpStatus.NOT_FOUND, "해당 특이사항이 존재하지 않습니다."),
    NOT_FOUND_SURBEY("4055", HttpStatus.NOT_FOUND, "해당 설문이 존재하지 않습니다."),
    NOT_FOUND_ANSWER("4056", HttpStatus.NOT_FOUND, "해당 설문결과가 존재하지 않습니다."),
    NOT_FOUND_NOTABLE_FEATURE("4057", HttpStatus.NOT_FOUND, "해당 특이사항이 존재하지 않습니다."),
    NOT_FOUND_MEDICAL_RECORD("4058", HttpStatus.NOT_FOUND, "해당 진료기록이 존재하지 않습니다."),
    NOT_FOUND_DIAGNOSIS("4057", HttpStatus.NOT_FOUND, "해당 과거 병명이 존재하지 않습니다."),
    NOT_FOUND_HEALTHFOOD("4058", HttpStatus.NOT_FOUND, "해당 건강기능 식품이 존재하지 않습니다."),
    NOT_FOUND_REGISTRATION("4059", HttpStatus.NOT_FOUND, "해당 등록신청 사항이 존재하지 않습니다."),
    NOT_FOUND_DOSENAME("4060", HttpStatus.NOT_FOUND, "해당 약의 이름이 존재하지 않습니다."),
    NOT_FOUND_GUARDIAN("4061", HttpStatus.NOT_FOUND, "해당 보호자 관계가 존재하지 않습니다."),

    // Bad Request Error
    NOT_END_POINT("4000", HttpStatus.BAD_REQUEST, "End Point가 존재하지 않습니다."),
    NOT_EQUAL("4001", HttpStatus.BAD_REQUEST, "Not Equal Error"),
    DUPLICATION_TITLE("4002", HttpStatus.BAD_REQUEST, "Duplication Title"),
    DUPLICATION_NAME("4003", HttpStatus.BAD_REQUEST, "Duplication Name"),
    EXIST_ENTITY_REQUEST("4004", HttpStatus.BAD_REQUEST, "Exist Entity Request"),
    NOT_EXIST_ENTITY_REQUEST("4005", HttpStatus.BAD_REQUEST, "Not Exist Entity Request"),
    NOT_EXIST_PARAMETER("4006", HttpStatus.BAD_REQUEST, "Not Exist Parameter Request"),
    PAYMENT_FAIL("4007", HttpStatus.BAD_REQUEST, "InValid Payment Information Request"),
    INVALID_ARGUMENT("4008", HttpStatus.BAD_REQUEST, "Invalid Argument"),
    INVALID_REGION("4009", HttpStatus.BAD_REQUEST, "Invalid REGION"),
    DUPLICATION_MEDICAL_APPOINTMENT("4010", HttpStatus.BAD_REQUEST, "이미 공유한 전문가입니다."),
    DUPLICATION_GUARDIAN("4012", HttpStatus.BAD_REQUEST, "해당 보호자 관계가 이미 있습니다."),
    EQUAL_GUARDIAN("4013", HttpStatus.BAD_REQUEST, "같은 유저는 보호자가 될 수 없습니다."),
    DUPLICATION_NOTABLE_FEATURE("4014", HttpStatus.BAD_REQUEST, "존재하는 특이사항입니다."),

    // Server, File Up/DownLoad Error
    SERVER_ERROR("5000", HttpStatus.INTERNAL_SERVER_ERROR, "API 서버 오류입니다. 혹은 아닐수도..."),

    NOT_IMAGE_ERROR("5024", HttpStatus.INTERNAL_SERVER_ERROR, "Image 업로드를 실패하였습니다."),

    /**
     * 502 Bad Gateway: Gateway Server Error
     */
    AUTH_SERVER_USER_INFO_ERROR("5020", HttpStatus.BAD_GATEWAY, "소셜 서버에서 유저 정보를 가져오는데 실패하였습니다."),

    FILE_UPLOAD("5021", HttpStatus.BAD_GATEWAY, "파일 업로드에 실패하였습니다."),

    FILE_DOWNLOAD("5022", HttpStatus.BAD_GATEWAY, "파일 다운로드에 실패하였습니다."),

    SEND_NOTIFICATION_ERROR("5023", HttpStatus.BAD_GATEWAY, "알림 전송에 실패하였습니다."),

    IDENTIFICATION_ERROR("5024", HttpStatus.BAD_GATEWAY, "본인 인증에 실패하였습니다."),

    // Access Denied Error
    ACCESS_DENIED_ERROR("4010", HttpStatus.UNAUTHORIZED, "액세스 권한이 없습니다."),

    /**
     * 401 Unauthorized: Authentication and Authorization Error
     */
    EXPIRED_TOKEN_ERROR("4010", HttpStatus.UNAUTHORIZED, "만료된 토큰입니다."),

    INVALID_TOKEN_ERROR("4011", HttpStatus.UNAUTHORIZED, "유효하지 않은 토큰입니다."),

    TOKEN_MALFORMED_ERROR("4012", HttpStatus.UNAUTHORIZED, "Malformed Token Error"),

    TOKEN_TYPE_ERROR("4014", HttpStatus.UNAUTHORIZED, "Type Token Error"),

    TOKEN_UNSUPPORTED_ERROR("4015", HttpStatus.UNAUTHORIZED, "Unsupported Token Error"),

    TOKEN_GENERATION_ERROR("4016", HttpStatus.UNAUTHORIZED, "Failed To Generate Token"),

    TOKEN_UNKNOWN_ERROR("4018", HttpStatus.UNAUTHORIZED, "Unknown Error"),

    INSUFFICIENT_PRIVILEGES_ERROR("4019", HttpStatus.UNAUTHORIZED, "Insufficient Privileges Error");

    private final String code;
    private final HttpStatus httpStatus;
    private final String message;
}