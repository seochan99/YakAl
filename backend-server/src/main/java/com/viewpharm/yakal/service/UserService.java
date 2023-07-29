package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.MobileUser;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.MobileUserRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.ESex;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final MobileUserRepository mobileUserRepository;

    public MobileUser getMobileUserInfo(final Long userId) {
        return mobileUserRepository.findById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
    }

    public void updateUserInfo(final Long userId, final String name, final Boolean isDetail, final LocalDate birthday, final ESex sex) {
        final Integer isUpdated = mobileUserRepository.updateNameAndBirthdayAndIsDetailAndSexById(userId, name, birthday, isDetail, sex);

        if (isUpdated == 0) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }
    }

    public void updateName(final Long userId, final String name) {
        final Integer isUpdated = userRepository.updateNameById(userId, name);

        if (isUpdated == 0) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }
    }

    public void updateIsDetail(final Long userId, final Boolean isDetail) {
        final Integer isUpdated = mobileUserRepository.updateIsDetailById(userId, isDetail);

        if (isUpdated == 0) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }
    }

    public void updateIsAllowedNotification(final Long userId, final Boolean isAllowedNotification) {
        final Integer isUpdated = mobileUserRepository.updateIsAllowedNotificationById(userId, isAllowedNotification);

        if (isUpdated == 0) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }
    }
}
