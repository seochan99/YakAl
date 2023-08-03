package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.MobileUser;
import com.viewpharm.yakal.domain.Notification;
import com.viewpharm.yakal.dto.NotificationDto;
import com.viewpharm.yakal.dto.request.NotificationUserRequestDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.MobileUserRepository;
import com.viewpharm.yakal.repository.MobileUserRepository.MobileUserNotificationForm;
import com.viewpharm.yakal.repository.NotificationRepository;
import com.viewpharm.yakal.repository.UserRepository;
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
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class NotificationService {
    private final NotificationRepository notificationRepository;
    private final NotificationUtil notificationUtil;
    private final MobileUserRepository mobileUserRepository;

    public List<NotificationDto> readNotification(Long userId, Long pageNum, Long num) {
        MobileUser mobileUser = mobileUserRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Pageable paging = PageRequest.of(pageNum.intValue(), num.intValue(), Sort.by(Sort.Direction.DESC, "createDate"));
        Page<Notification> notifications = notificationRepository.findByMobileUserAndStatus(mobileUser, paging, true);

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

        notification.builder().isRead(Boolean.TRUE).build();

        return Boolean.TRUE;
    }

    public Boolean deleteNotification(Long userId, Long notificationId) {
        MobileUser mobileUser = mobileUserRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        Notification notification = notificationRepository.findByIdAndMobileUserId(notificationId, userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_NOTIFICATION));

        if (mobileUser.getId() != notification.getMobileUser().getId()) {
            throw new CommonException(ErrorCode.NOT_EQUAL);
        }
        notification.builder().status(false).build();
        //notificationRepository.delete(notification);
        return Boolean.TRUE;
    }
}
