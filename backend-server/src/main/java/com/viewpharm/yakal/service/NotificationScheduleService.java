package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.domain.Notification;
import com.viewpharm.yakal.dto.request.NotificationUserRequestDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.repository.NotificationRepository;
import com.viewpharm.yakal.utils.NotificationUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
    private final UserRepository userRepository;


    //특정 시간에 디비에서 오늘 특정 시간 안 약 가져오기
    //약 유저 확인
    //유저의 디바이스 토큰 가져와서 알림 보내기

    //매일 아침7-11시 10분 간격 실행
//    @Scheduled(cron = "0 0/30 7-11 * * *")
//    @SchedulerLock(
//            name = "scheduledSendingMorningNotification",
//            lockAtLeastFor = "PT29M",
//            lockAtMostFor = "PT29M")
    public void sendPushNotificationOnMorning() throws Exception {
        //현재 날짜
        LocalDate nowDate = LocalDate.now();
        LocalTime nowTime = LocalTime.now();
        //날짜와 시간으로 알약 리스트 찾기

        List<UserRepository.UserNotificationForm> userInformations = userRepository.findByDateAndBreakfastTime(nowDate, nowTime);
        NotificationUserRequestDto notificationUserRequestDto;

        for (UserRepository.UserNotificationForm userInformation : userInformations) {
            String title = userInformation.getUsername() + "님, 저녁 약 드실 시간이네요!";
            String content = userInformation.getCount() + "개 먹어야 해요!"; //갯수 가져와서 넣기
            Long userId = userInformation.getUserId();

            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
            Notification notification = Notification.builder()
                    .title(title)
                    .content(content)
                    .user(user).build();

            notificationRepository.save(notification);


            notificationUserRequestDto = NotificationUserRequestDto.builder()
                    .targetUserId(userId)
                    .title(title)
                    .body(content).build();
            notificationUtil.sendNotificationByToken(notificationUserRequestDto);

        }
    }

    //매일 오후 11-17시 10분 간격 실행
//    @Scheduled(cron = "0 0/30 11-17 * * *")
//    @SchedulerLock(
//            name = "scheduledSendingLunchNotification",
//            lockAtLeastFor = "PT29M",
//            lockAtMostFor = "PT29M")
    public void sendPushNotificationOnLunch() throws Exception {
        //현재 날짜
        LocalDate nowDate = LocalDate.now();
        LocalTime nowTime = LocalTime.now();
        //날짜와 시간으로 알약 리스트 찾기

        List<UserRepository.UserNotificationForm> userInformations = userRepository.findByDateAndLunchTime(nowDate, nowTime);
        NotificationUserRequestDto notificationUserRequestDto;

        for (UserRepository.UserNotificationForm userInformation : userInformations) {
            String title = userInformation.getUsername() + "님, 저녁 약 드실 시간이네요!";
            String content = userInformation.getCount() + "개 먹어야 해요!"; //갯수 가져와서 넣기
            Long userId = userInformation.getUserId();

            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
            Notification notification = Notification.builder()
                    .title(title)
                    .content(content)
                    .user(user).build();

            notificationRepository.save(notification);

            notificationUserRequestDto = NotificationUserRequestDto.builder()
                    .targetUserId(userId)
                    .title(title)
                    .body(content).build();
            notificationUtil.sendNotificationByToken(notificationUserRequestDto);
        }
    }

    //매일 저녁 17-23시 30분 간격 실행
//    @Scheduled(cron = "0 0/30 17-23 * * *")
//    @SchedulerLock(
//            name = "scheduledSendingDinnerNotification",
//            lockAtLeastFor = "PT29M",
//            lockAtMostFor = "PT29M")
    public void sendPushNotificationOnDinner() throws Exception {
        //현재 날짜
        LocalDate nowDate = LocalDate.now();
        LocalTime nowTime = LocalTime.now();
        //날짜와 시간으로 알약 리스트 찾기

        List<UserRepository.UserNotificationForm> userInformations = userRepository.findByDateAndDinnerTime(nowDate, nowTime);
        //List<User> users = userRepository.findByDateAndTime(nowDate, nowTime);

        NotificationUserRequestDto notificationUserRequestDto;

        for (UserRepository.UserNotificationForm userInformation : userInformations) {
            String title = userInformation.getUsername() + "님, 저녁 약 드실 시간이네요!";
            String content = userInformation.getCount() + "개 먹어야 해요!"; //갯수 가져와서 넣기
            Long userId = userInformation.getUserId();

            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
            Notification notification = Notification.builder()
                    .title(title)
                    .content(content)
                    .user(user).build();

            notificationRepository.save(notification);

            notificationUserRequestDto = NotificationUserRequestDto.builder()
                    .targetUserId(userId)
                    .title(title)
                    .body(content).build();
            notificationUtil.sendNotificationByToken(notificationUserRequestDto);
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
        List<UserRepository.UserNotificationForm> userInformations = userRepository.findByDateAndTime(nowDate, nowTime);

        NotificationUserRequestDto notificationUserRequestDto;
        for (UserRepository.UserNotificationForm userInformation : userInformations) {
            String title = userInformation.getUsername() + "님, 저녁 약 드실 시간이네요!";
            String content = userInformation.getCount() + "개 먹어야 해요!"; //갯수 가져와서 넣기
            Long userId = userInformation.getUserId();

            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
            Notification notification = Notification.builder()
                    .title(title)
                    .content(content)
                    .user(user).build();

            notificationRepository.save(notification);


            notificationUserRequestDto = NotificationUserRequestDto.builder()
                    .targetUserId(userId)
                    .title(title)
                    .body(content).build();
            notificationUtil.sendNotificationByToken(notificationUserRequestDto);
        }
        return Boolean.TRUE;
    }

    public Boolean sendPushNotificationTest2(Long userId, NotificationUserRequestDto requestDto) throws Exception {

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        notificationRepository.save(Notification.builder()
                .title(requestDto.getTitle())
                .content(requestDto.getBody())
                .user(user).build());

        return Boolean.TRUE;
    }
}
