package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.MobileUser;
import com.viewpharm.yakal.domain.Notification;
import com.viewpharm.yakal.dto.request.NotificationUserRequestDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.MobileUserRepository;
import com.viewpharm.yakal.repository.NotificationRepository;
import com.viewpharm.yakal.utils.NotificationUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.javacrumbs.shedlock.spring.annotation.SchedulerLock;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class NotificationScheduleService {
    private final NotificationRepository notificationRepository;
    private final NotificationUtil notificationUtil;
    private final MobileUserRepository mobileUserRepository;


    //특정 시간에 디비에서 오늘 특정 시간 안 약 가져오기
    //약 유저 확인
    //유저의 디바이스 토큰 가져와서 알림 보내기

    //매일 아침7-11시 10분 간격 실행
    @Scheduled(cron = "0 0/30 7-11 * * *")
    @SchedulerLock(
            name = "scheduledSendingMorningNotification",
            lockAtLeastFor = "PT29M",
            lockAtMostFor = "PT29M")
    public void sendPushNotificationOnMorning() throws Exception {
        //현재 날짜
        LocalDate nowDate = LocalDate.now();
        LocalTime nowTime = LocalTime.now();
        //날짜와 시간으로 알약 리스트 찾기
        // 레포로 옮기기
        //select user_id from doses where date='2023-07-24' and time ='DINNER' group by user_id;

        List<MobileUserRepository.MobileUserNotificationForm> userInformations = mobileUserRepository.findByDateAndBreakfastTime(nowDate, nowTime);
        NotificationUserRequestDto notificationUserRequestDto;

        for (MobileUserRepository.MobileUserNotificationForm userInformation : userInformations) {
            String title = userInformation.getUsername() + "님, 저녁 약 드실 시간이네요!";
            String content = userInformation.getCount() + "개 먹어야 해요!"; //갯수 가져와서 넣기
            Long userId = userInformation.getUserId();
            log.info("title = " + title);
            log.info("content = " + content);

            MobileUser mobileUser = mobileUserRepository.findById(userId)
                    .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
            Notification notification = Notification.builder()
                    .title(title)
                    .content(content)
                    .mobileUser(mobileUser).build();

            notificationRepository.save(notification);

            if (mobileUser.getIsIos()) { //ios 푸시알림
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

    //매일 오후 11-17시 10분 간격 실행
    @Scheduled(cron = "0 0/30 11-17 * * *")
    @SchedulerLock(
            name = "scheduledSendingLunchNotification",
            lockAtLeastFor = "PT29M",
            lockAtMostFor = "PT29M")
    public void sendPushNotificationOnLunch() throws Exception {
        //현재 날짜
        LocalDate nowDate = LocalDate.now();
        LocalTime nowTime = LocalTime.now();
        //날짜와 시간으로 알약 리스트 찾기
        // 레포로 옮기기
        //select user_id from doses where date='2023-07-24' and time ='DINNER' group by user_id;

        List<MobileUserRepository.MobileUserNotificationForm> userInformations = mobileUserRepository.findByDateAndLunchTime(nowDate, nowTime);
        NotificationUserRequestDto notificationUserRequestDto;

        for (MobileUserRepository.MobileUserNotificationForm userInformation : userInformations) {
            String title = userInformation.getUsername() + "님, 저녁 약 드실 시간이네요!";
            String content = userInformation.getCount() + "개 먹어야 해요!"; //갯수 가져와서 넣기
            Long userId = userInformation.getUserId();
            log.info("title = " + title);
            log.info("content = " + content);

            MobileUser mobileUser = mobileUserRepository.findById(userId)
                    .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
            Notification notification = Notification.builder()
                    .title(title)
                    .content(content)
                    .mobileUser(mobileUser).build();

            notificationRepository.save(notification);

            if (mobileUser.getIsIos()) { //ios 푸시알림
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

    //매일 저녁 17-23시 30분 간격 실행
    @Scheduled(cron = "0 0/30 17-23 * * *")
    @SchedulerLock(
            name = "scheduledSendingDinnerNotification",
            lockAtLeastFor = "PT29M",
            lockAtMostFor = "PT29M")
    public void sendPushNotificationOnDinner() throws Exception {
        //현재 날짜
        LocalDate nowDate = LocalDate.now();
        LocalTime nowTime = LocalTime.now();
        //날짜와 시간으로 알약 리스트 찾기
        // 레포로 옮기기
        //select user_id from doses where date='2023-07-24' and time ='DINNER' group by user_id;

        List<MobileUserRepository.MobileUserNotificationForm> userInformations = mobileUserRepository.findByDateAndDinnerTime(nowDate, nowTime);
        //List<MobileUser> mobileUsers = mobileUserRepository.findByDateAndTime(nowDate, nowTime);

        NotificationUserRequestDto notificationUserRequestDto;

        for (MobileUserRepository.MobileUserNotificationForm userInformation : userInformations) {
            String title = userInformation.getUsername() + "님, 저녁 약 드실 시간이네요!";
            String content = userInformation.getCount() + "개 먹어야 해요!"; //갯수 가져와서 넣기
            Long userId = userInformation.getUserId();
            log.info("title = " + title);
            log.info("content = " + content);

            MobileUser mobileUser = mobileUserRepository.findById(userId)
                    .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
            Notification notification = Notification.builder()
                    .title(title)
                    .content(content)
                    .mobileUser(mobileUser).build();

            notificationRepository.save(notification);

            if (mobileUser.getIsIos()) { //ios 푸시알림
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

    public Boolean sendPushNotificationTest() throws Exception {
        //현재 날짜
//        LocalDate nowDate = LocalDate.now();
//        LocalTime nowTime = LocalTime.now();
        LocalDate nowDate = LocalDate.of(2023, 8, 8);
        LocalTime nowTime = LocalTime.of(22, 0, 0);
        //날짜와 시간으로 알약 리스트 찾기
        // 레포로 옮기기
        //select user_id from doses where date='2023-07-24' and time ='DINNER' group by user_id;

        //유저 id, 이름, 약 갯수 가져오기
        List<MobileUserRepository.MobileUserNotificationForm> userInformations = mobileUserRepository.findByDateAndTime(nowDate, nowTime);
        System.out.println(userInformations.get(1).getUserId());
        System.out.println(userInformations.get(1).getUsername());
        System.out.println(userInformations.get(1).getCount());
        //List<MobileUser> mobileUsers = mobileUserRepository.findByDateAndTime(nowDate, nowTime);
        System.out.println("size = " + userInformations.size());
        NotificationUserRequestDto notificationUserRequestDto;
        for (MobileUserRepository.MobileUserNotificationForm userInformation : userInformations) {
            String title = userInformation.getUsername() + "님, 저녁 약 드실 시간이네요!";
            String content = userInformation.getCount() + "개 먹어야 해요!"; //갯수 가져와서 넣기
            Long userId = userInformation.getUserId();
            log.info("title = " + title);
            log.info("content = " + content);

            MobileUser mobileUser = mobileUserRepository.findById(userId)
                    .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
            Notification notification = Notification.builder()
                    .title(title)
                    .content(content)
                    .mobileUser(mobileUser).build();

            notificationRepository.save(notification);

            if (mobileUser.getIsIos()) { //ios 푸시알림
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
        log.info("끝");
        return Boolean.TRUE;
    }
}
