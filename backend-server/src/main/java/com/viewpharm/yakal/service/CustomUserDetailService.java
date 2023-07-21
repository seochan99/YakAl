package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.CustomUserDetail;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;

@Service
public class CustomUserDetailService implements UserDetailsService {
    private final UserRepository userRepository;

    @Autowired
    public CustomUserDetailService(final UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Collection<SimpleGrantedAuthority> roles = new ArrayList<>(1);
        roles.add(new SimpleGrantedAuthority("ROLE_USER"));

        User user = userRepository.findByIdAndIsLoginAndRefreshTokenIsNotNull(Long.valueOf(username), true)
                .orElseThrow(() -> new UsernameNotFoundException("ACCESS_DENIED_ERROR"));

        return CustomUserDetail.create(user);
    }
}
