package com.viewpharm.yakal.common.security;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.repository.UserRepository;
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

    @Override
    public UserDetails loadUserByUsername(String username) throws CommonException {
        final Long userId = Long.valueOf(username);
        final User user = userRepository.findByIdAndIsLoginAndRefreshTokenIsNotNull(userId, true)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        return UserDetailForIdOnly.create(user);
    }
}
