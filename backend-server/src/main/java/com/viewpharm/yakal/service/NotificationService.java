package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Notification;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.NotificationDto;
import com.viewpharm.yakal.dto.request.NotificationUserRequestDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.NotificationRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.EDosingTime;
import com.viewpharm.yakal.utils.NotificationUtil;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.javacrumbs.shedlock.spring.annotation.SchedulerLock;
import org.springframework.cglib.core.Local;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class NotificationService {
    private final UserRepository userRepository;
    private final NotificationRepository notificationRepository;
    private final NotificationUtil notificationUtil;

    public List<NotificationDto> readNotification(Long userId, Long pageNum, Long num) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Pageable paging = PageRequest.of(pageNum.intValue(), num.intValue(), Sort.by(Sort.Direction.DESC, "createDate"));
        Page<Notification> notifications = notificationRepository.findByUser(user, paging);

        List<NotificationDto> notificationDtoList = new ArrayList<>();
        for (Notification notification : notifications) {
            notificationDtoList.add(NotificationDto.builder()
                    .id(notification.getId())
                    .title(notification.getTitle())
                    .content(notification.getContent())
                    .createdDate(notification.getCreatedDate())
                    .isRead(notification.getIsRead()).build());
        }
        return notificationDtoList;
    }

    public Boolean updateNotification(Long userId, Long notificationId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        Notification notification = notificationRepository.findByIdAndUserId(notificationId, userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_NOTIFICATION));

        if (user.getId() != notification.getUser().getId()) {
            throw new CommonException(ErrorCode.NOT_EQUAL);
        }

        notification.builder().isRead(Boolean.TRUE).build();

        return Boolean.TRUE;
    }

    public Boolean deleteNotification(Long userId, Long notificationId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        Notification notification = notificationRepository.findByIdAndUserId(notificationId, userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_NOTIFICATION));

        if (user.getId() != notification.getUser().getId()) {
            throw new CommonException(ErrorCode.NOT_EQUAL);
        }

        notificationRepository.delete(notification);
        return Boolean.TRUE;
    }


    //특정 시간에 디비에서 오늘 특정 시간 안 약 가져오기
    //약 유저 확인
    //유저의 디바이스 토큰 가져와서 알림 보내기

    //매일 아침 8시 실행
    @Scheduled(cron = "0 0 8 * * *")
    @SchedulerLock(
            name = "scheduledSendingMorningNotification",
            lockAtLeastFor = "PT30S",
            lockAtMostFor = "PT30S")
    public void sendPushNotificationOnMorning() throws Exception {
        //현재 날짜
        LocalDate nowDate = LocalDate.now();
        //날짜와 시간으로 알약 리스트 찾기
        // 레포로 옮기기
        //select user_id from doses where date='2023-07-24' and time ='DINNER' group by user_id;

        List<UserRepository.UserNotificationFrom> users = userRepository.findByDateAndTime(nowDate, EDosingTime.BREAKFAST);
        NotificationUserRequestDto notificationUserRequestDto;

        for (UserRepository.UserNotificationFrom user : users) {
            String title = user.getUser().getName() + "님, 아침 약 드실 시간이네요!";
            String content = user.getCount() + "개 먹어야 해요!"; //갯수 가져와서 넣기
            Long userId = user.getUser().getId();
            if (user.getUser().getIsIos()) { //ios 푸시알림
                notificationUserRequestDto = NotificationUserRequestDto.builder()
                        .targetUserId(userId)
                        .title(title)
                        .body(content).build();
                notificationUtil.sendApnFcmtoken(notificationUserRequestDto);
            } else { //안드로이드 푸시알림
                notificationUserRequestDto = NotificationUserRequestDto.builder()
                        .targetUserId(userId)
                        .title(title)
                        .body(content).build();
                notificationUtil.sendNotificationByToken(notificationUserRequestDto); //버전1
                //notificationUtil.sendMessageTo(fcmNotificationDto); //버전2
            }
        }
    }

    //매일 오후 12시 실행
    @Scheduled(cron = "0 0 12 * * *")
    @SchedulerLock(
            name = "scheduledSendingLunchNotification",
            lockAtLeastFor = "PT30S",
            lockAtMostFor = "PT30S")
    public void sendPushNotificationOnLunch() throws Exception {
        //현재 날짜
        LocalDate nowDate = LocalDate.now();
        //날짜와 시간으로 알약 리스트 찾기
        // 레포로 옮기기
        //select user_id from doses where date='2023-07-24' and time ='DINNER' group by user_id;

        List<UserRepository.UserNotificationFrom> users = userRepository.findByDateAndTime(nowDate, EDosingTime.LUNCH);
        NotificationUserRequestDto notificationUserRequestDto;

        for (UserRepository.UserNotificationFrom user : users) {
            String title = user.getUser().getName() + "님, 점심 약 드실 시간이네요!";
            String content = user.getCount() + "개 먹어야 해요!"; //갯수 가져와서 넣기
            Long userId = user.getUser().getId();
            if (user.getUser().getIsIos()) { //ios 푸시알림
                notificationUserRequestDto = NotificationUserRequestDto.builder()
                        .targetUserId(userId)
                        .title(title)
                        .body(content).build();
                notificationUtil.sendApnFcmtoken(notificationUserRequestDto);
            } else { //안드로이드 푸시알림
                notificationUserRequestDto = NotificationUserRequestDto.builder()
                        .targetUserId(userId)
                        .title(title)
                        .body(content).build();
                notificationUtil.sendNotificationByToken(notificationUserRequestDto); //버전1
                //notificationUtil.sendMessageTo(fcmNotificationDto); //버전2
            }
        }
    }

    //매일 저녁 18시 실행
    @Scheduled(cron = "0 0 18 * * *")
    @SchedulerLock(
            name = "scheduledSendingDinnerNotification",
            lockAtLeastFor = "PT30S",
            lockAtMostFor = "PT30S")
    public void sendPushNotificationOnDinner() throws Exception {
        //현재 날짜
        LocalDate nowDate = LocalDate.now();
        //날짜와 시간으로 알약 리스트 찾기
        // 레포로 옮기기
        //select user_id from doses where date='2023-07-24' and time ='DINNER' group by user_id;

        List<UserRepository.UserNotificationFrom> users = userRepository.findByDateAndTime(nowDate, EDosingTime.DINNER);
        NotificationUserRequestDto notificationUserRequestDto;

        for (UserRepository.UserNotificationFrom user : users) {
            String title = user.getUser().getName() + "님, 저녁 약 드실 시간이네요!";
            String content = user.getCount() + "개 먹어야 해요!"; //갯수 가져와서 넣기
            Long userId = user.getUser().getId();
            if (user.getUser().getIsIos()) { //ios 푸시알림
                notificationUserRequestDto = NotificationUserRequestDto.builder()
                        .targetUserId(userId)
                        .title(title)
                        .body(content).build();
                notificationUtil.sendApnFcmtoken(notificationUserRequestDto);
            } else { //안드로이드 푸시알림
                notificationUserRequestDto = NotificationUserRequestDto.builder()
                        .targetUserId(userId)
                        .title(title)
                        .body(content).build();
                notificationUtil.sendNotificationByToken(notificationUserRequestDto); //버전1
                //notificationUtil.sendMessageTo(fcmNotificationDto); //버전2
            }
        }
    }

    public Boolean sendPushNotificationTest(LocalDate localDate, EDosingTime eDosingTime) throws Exception {
        //현재 날짜
        //날짜와 시간으로 알약 리스트 찾기
        // 레포로 옮기기
        //select user_id from doses where date='2023-07-24' and time ='DINNER' group by user_id;

        List<UserRepository.UserNotificationFrom> users = userRepository.findByDateAndTime(localDate, eDosingTime);
        NotificationUserRequestDto notificationUserRequestDto;

        for (UserRepository.UserNotificationFrom user : users) {
            String title = user.getUser().getName() + "님, 아침 약 드실 시간이네요!";
            String content = user.getCount() + "개 먹어야 해요!"; //갯수 가져와서 넣기
            Long userId = user.getUser().getId();
            log.info("UserId : " + userId + " UserName : " + user.getUser().getName());
        }
        return Boolean.TRUE;
    }


}
