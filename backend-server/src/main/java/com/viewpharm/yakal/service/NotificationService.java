package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.MobileUser;
import com.viewpharm.yakal.domain.Notification;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.NotificationDto;
import com.viewpharm.yakal.dto.NotificationUserRequestDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.NotificationRepository;
import com.viewpharm.yakal.repository.MobileUserRepository;
import com.viewpharm.yakal.type.EDosingTime;
import com.viewpharm.yakal.utils.NotificationUtil;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.javacrumbs.shedlock.spring.annotation.SchedulerLock;
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
@Transactional
@RequiredArgsConstructor
public class NotificationService {

    private final MobileUserRepository mobileUserRepository;
    private final NotificationRepository notificationRepository;
    private final NotificationUtil notificationUtil;

    public List<NotificationDto> readNotification(Long userId, Long pageNum, Long num) {
        MobileUser mobileUser = mobileUserRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Pageable paging = PageRequest.of(pageNum.intValue(), num.intValue(), Sort.by(Sort.Direction.DESC, "createDate"));
        Page<Notification> notifications = notificationRepository.findByMobileUser(mobileUser, paging);

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
        MobileUser mobileUser = mobileUserRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        Notification notification = notificationRepository.findByIdAndMobileUserId(notificationId, userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_NOTIFICATION));

        if (mobileUser.getId() != notification.getMobileUser().getId()) {
            throw new CommonException(ErrorCode.NOT_EQUAL);
        }

        notification.setIsRead(true);

        return Boolean.TRUE;
    }

    public Boolean deleteNotification(Long userId, Long notificationId) {
        MobileUser mobileUser = mobileUserRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        Notification notification = notificationRepository.findByIdAndMobileUserId(notificationId, userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_NOTIFICATION));

        if (mobileUser.getId() != notification.getMobileUser().getId()) {
            throw new CommonException(ErrorCode.NOT_EQUAL);
        }

        notificationRepository.delete(notification);
        return Boolean.TRUE;
    }


    //특정 시간대에 약 먹어야 한다 + 몇 개 남았다 알림 보내기
    //동적으로 시간대 받는 방법이 도저히 안나와서
    //특정 시간에대 함수를 호출하고 db에서 약 시간 확인하고
    //몇 분뒤에 먹어야 하는지 출력만 하는 방식으로 일단 할 듯

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

        List<MobileUserRepository.UserNotificationFrom> users = mobileUserRepository.findByDateAndTime(nowDate, EDosingTime.MORNING);
        NotificationUserRequestDto notificationUserRequestDto;

        for (MobileUserRepository.UserNotificationFrom user : users) {
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

        List<MobileUserRepository.UserNotificationFrom> users = mobileUserRepository.findByDateAndTime(nowDate, EDosingTime.AFTERNOON);
        NotificationUserRequestDto notificationUserRequestDto;

        for (MobileUserRepository.UserNotificationFrom user : users) {
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

        List<MobileUserRepository.UserNotificationFrom> users = mobileUserRepository.findByDateAndTime(nowDate, EDosingTime.EVENING);
        NotificationUserRequestDto notificationUserRequestDto;

        for (MobileUserRepository.UserNotificationFrom user : users) {
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
}
