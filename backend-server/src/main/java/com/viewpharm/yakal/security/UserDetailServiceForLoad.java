package com.viewpharm.yakal.security;

import com.viewpharm.yakal.domain.MobileUser;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.MobileUserRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.ERole;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserDetailServiceForLoad implements UserDetailsService {

    private final UserRepository userRepository;
    private final MobileUserRepository mobileUserRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws CommonException {
        final Long userId = Long.valueOf(username);
        final ERole role = userRepository.getRoleById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER_ERROR));

        if (role == ERole.ROLE_MOBILE) {
            final MobileUser user = mobileUserRepository.findByIdAndIsLoginAndRefreshTokenIsNotNull(userId, true)
                    .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER_ERROR));
            return UserDetailForIdOnly.create(user);
        } else {
            // 임시, Web에 해당하는 User Load 로직을 작성해야 함
            final MobileUser user = mobileUserRepository.findByIdAndIsLoginAndRefreshTokenIsNotNull(userId, true)
                    .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER_ERROR));
            return UserDetailForIdOnly.create(user);
        }
    }
}
