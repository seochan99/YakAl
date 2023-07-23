package com.viewpharm.yakal.utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.google.gson.JsonParseException;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.MessageDto;
import com.viewpharm.yakal.dto.request.NotificationUserRequestDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.UserRepository;
import javapns.Push;
import javapns.communication.exceptions.CommunicationException;
import javapns.communication.exceptions.KeystoreException;
import javapns.notification.PushNotificationPayload;
import javapns.notification.PushedNotification;
import javapns.notification.ResponsePacket;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.json.JSONException;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpHeaders;
import java.io.IOException;
import java.util.List;

@Slf4j
@Configuration
@RequiredArgsConstructor
public class NotificationUtil {
    private final FirebaseMessaging firebaseMessaging;
    private final UserRepository userRepository;

    //ios 푸시알림
    public void sendApnFcmtoken(NotificationUserRequestDto requestDto) throws Exception {
        User user = userRepository.findById(requestDto.getTargetUserId()).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        if (user.getDeviceToken() != null) {
            try {
                PushNotificationPayload payload = PushNotificationPayload.complex();
                payload.addAlert(requestDto.getTitle());
                payload.getPayload().put("message", requestDto.getBody());
                payload.addBadge(1);
                payload.addSound("default");
                payload.addCustomDictionary("id", "1");
                System.out.println(payload.toString());
                Object obj = user.getDeviceToken();
                ClassPathResource resource = new ClassPathResource("SpringPushNotification.p12");
                //나중에 APNS 등록하고 받은 키 경로 -> 바로 윗줄은 서버 배포용 아랫줄은 로컬용
                //List<PushedNotification> NOTIFICATIONS = Push.payload(payload, "C:\Users\woobi\Documents\WeAreBility\2023-1-OSSP2-WeAreBility-3\backend\src\main\resources\\Certificates.p12", "naemansan@", false, obj);
                List<PushedNotification> NOTIFICATIONS = Push.payload(payload, resource.getPath(), "naemansan@", false, obj);
                for (PushedNotification NOTIFICATION : NOTIFICATIONS) {
                    if (NOTIFICATION.isSuccessful()) {
                        log.info("PUSH NOTIFICATION SENT SUCCESSFULLY TO" + NOTIFICATION.getDevice().getToken());
                    } else {
                        //부적절한 토큰 DB에서 삭제하기
                        Exception THEPROBLEM = NOTIFICATION.getException();
                        THEPROBLEM.printStackTrace();
                        ResponsePacket THEERRORRESPONSE = NOTIFICATION.getResponse();
                        if (THEERRORRESPONSE != null) {
                            log.info(THEERRORRESPONSE.getMessage());
                        }
                    }
                }
            } catch (KeystoreException e) {
                e.printStackTrace();
            } catch (JSONException e) {
                e.printStackTrace();
            } catch (CommunicationException e) {
                e.printStackTrace();
            }
            log.info("알림을 성공적으로 전송했습니다. targetUserID=" + requestDto.getTargetUserId());
        } else {
            log.info("서버에 저장된 해당 유저의 FirebaseToken이 존재하지 않습니다. targetUserID=" + requestDto.getTargetUserId());
        }
    }

    //안드로이드 버전 1
    public void sendNotificationByToken(NotificationUserRequestDto requestDto) {
        User user = userRepository.findById(requestDto.getTargetUserId()).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (user.getDeviceToken() != null) {
            Notification notification = Notification.builder()
                    .setTitle(requestDto.getTitle())
                    .setBody(requestDto.getBody())
                    .build();

            Message message = Message.builder()
                    .setToken(user.getDeviceToken())
                    .setNotification(notification)
                    .build();

            try {
                firebaseMessaging.send(message);
                log.info("알림을 성공적으로 전송했습니다. targetUserID=" + requestDto.getTargetUserId());
            } catch (FirebaseMessagingException e) {
                e.printStackTrace();
                log.info("알림 보내기를 실패하였습니다. targetUserID=" + requestDto.getTargetUserId());
            }
        } else {
            log.info("서버에 저장된 해당 유저의 FirebaseToken이 존재하지 않습니다. targetUserID=" + requestDto.getTargetUserId());
        }
    }

    //안드로이드 버전2
    private final String API_URL = "https://fcm.googleapis.com/v1/projects/wearebility-303e9/messages:send";
    private final ObjectMapper objectMapper;

    public void sendMessageTo(NotificationUserRequestDto requestDto) throws IOException {
        User user = userRepository.findById(requestDto.getTargetUserId()).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        if (user.getDeviceToken() != null) {
            String message = makeMessage(user.getDeviceToken(), requestDto.getTitle(), requestDto.getBody());
            OkHttpClient client = new OkHttpClient();
            RequestBody requestBody = RequestBody.create(message, MediaType.get("application/json; charset=utf-8"));
            Request request = new Request.Builder()
                    .url(API_URL)
                    .post(requestBody)
                    .addHeader(HttpHeaders.AUTHORIZATION, "Bearer " + getAccessToken())
                    .addHeader(HttpHeaders.CONTENT_TYPE, "application/json; UTF-8")
                    .build();
            Response response = client.newCall(request).execute();
            log.info(response.body().string());
        } else {
            log.info("서버에 저장된 해당 유저의 FirebaseToken이 존재하지 않습니다. targetUserID=" + requestDto.getTargetUserId());
        }
    }
    //안드로이드 버전2 - 메시지 생성
    private String makeMessage(String targetToken, String title, String body) throws
            JsonParseException, JsonProcessingException {
        MessageDto messageDto = MessageDto.builder()
                .message(MessageDto.Message.builder()
                        .token(targetToken)
                        .messageNotification(MessageDto.MessageNotification.builder()
                                .title(title)
                                .body(body)
                                .image(null)
                                .build()
                        ).build()).validateOnly(false).build();
        return objectMapper.writeValueAsString(messageDto);
    }
    //안드로이드 버전2 - AccessToken 가져오기 Config 클래스 대신 쓰는거
    private String getAccessToken() throws IOException {
        String firebaseConfigPath = "firebase/firebase_service_key.json";

        GoogleCredentials googleCredentials = GoogleCredentials
                .fromStream(new ClassPathResource(firebaseConfigPath).getInputStream())
                .createScoped(List.of("https://www.googleapis.com/auth/cloud-platform"));

        googleCredentials.refreshIfExpired();
        return googleCredentials.getAccessToken().getTokenValue();
    }


}
