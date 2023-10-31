package com.viewpharm.yakal.base.utils;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;

import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.dto.request.NotificationUserRequestDto;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;

@Slf4j
@Configuration
@RequiredArgsConstructor
public class NotificationUtil {

    private final FirebaseMessaging firebaseMessaging;
    private final UserRepository userRepository;

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
}
