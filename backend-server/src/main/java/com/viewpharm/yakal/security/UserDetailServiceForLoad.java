package com.viewpharm.yakal.security;

import com.viewpharm.yakal.domain.MobileUser;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.MobileUserRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.ERole;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserDetailServiceForLoad implements UserDetailsService {

    private final UserRepository userRepository;
    private final MobileUserRepository mobileUserRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws CommonException {
        final Long userId = Long.valueOf(username);
        final MobileUser user = mobileUserRepository.findByIdAndIsLoginAndRefreshTokenIsNotNull(userId, true)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        return UserDetailForIdOnly.create(user);
    }
}
