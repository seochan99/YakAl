package com.viewpharm.yakal.config;

import com.viewpharm.yakal.common.Constants;
import com.viewpharm.yakal.security.UserDetailServiceForLoad;
import com.viewpharm.yakal.security.JwtAuthenticationFilter;
import com.viewpharm.yakal.security.JwtExceptionFilter;
import com.viewpharm.yakal.security.JwtAccessDenied;
import com.viewpharm.yakal.security.JwtAuthEntryPoint;
import com.viewpharm.yakal.security.JwtProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;


import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig{

    private final JwtProvider jwtProvider;
    private final UserDetailServiceForLoad userDetailServiceForLoad;
    private final JwtAuthEntryPoint jwtAuthEntryPoint;
    private final JwtAccessDenied jwtAccessDeniedHandler;

    @Bean
    protected SecurityFilterChain securityFilterChain(final HttpSecurity httpSecurity) throws Exception {
        return httpSecurity
                .csrf(AbstractHttpConfigurer::disable)
                .httpBasic(AbstractHttpConfigurer::disable)
                .sessionManagement((sessionManagement) ->
                        sessionManagement.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )

                .authorizeHttpRequests(requestMatcherRegistry -> requestMatcherRegistry
                        .requestMatchers(Constants.NO_NEED_AUTH_URLS).permitAll()
                        .anyRequest().authenticated())

                .exceptionHandling(exception -> exception.authenticationEntryPoint(jwtAuthEntryPoint))
                .exceptionHandling(exception -> exception.accessDeniedHandler(jwtAccessDeniedHandler))

                .addFilterBefore(new JwtAuthenticationFilter(jwtProvider, userDetailServiceForLoad), UsernamePasswordAuthenticationFilter.class)
                .addFilterBefore(new JwtExceptionFilter(), JwtAuthenticationFilter.class)

                .getOrBuild();
    }
}
