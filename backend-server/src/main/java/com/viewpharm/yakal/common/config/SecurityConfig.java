package com.viewpharm.yakal.common.config;

import com.viewpharm.yakal.service.CustomUserDetailService;
import com.viewpharm.yakal.type.EUserRole;
import com.viewpharm.yakal.common.Constants;
import com.viewpharm.yakal.common.jwt.filter.JwtAuthenticationFilter;
import com.viewpharm.yakal.common.jwt.filter.JwtExceptionFilter;
import com.viewpharm.yakal.common.jwt.handler.JwtAccessDenied;
import com.viewpharm.yakal.common.jwt.handler.JwtAuthEntryPoint;
import com.viewpharm.yakal.common.jwt.service.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;


import org.springframework.security.config.annotation.web.configurers.CsrfConfigurer;
import org.springframework.security.config.annotation.web.configurers.HttpBasicConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final JwtService jwtService;
    private final CustomUserDetailService customUserDetailService;
    private final JwtAuthEntryPoint jwtAuthEntryPoint;
    private final JwtAccessDenied jwtAccessDeniedHandler;

    @Bean
    protected SecurityFilterChain securityFilterChain(final HttpSecurity httpSecurity) throws Exception {
        return httpSecurity
                .authorizeHttpRequests(requestMatcherRegistry -> requestMatcherRegistry
                        .requestMatchers(Constants.NO_NEED_AUTH_URLS).permitAll()
                        .requestMatchers("/admin/**").hasRole(EUserRole.ADMIN.toString())
                        .anyRequest().authenticated())

                .exceptionHandling(exception -> exception.authenticationEntryPoint(jwtAuthEntryPoint))
                .exceptionHandling(exception -> exception.accessDeniedHandler(jwtAccessDeniedHandler))

                .addFilterBefore(new JwtAuthenticationFilter(jwtService, customUserDetailService), UsernamePasswordAuthenticationFilter.class)
                .addFilterBefore(new JwtExceptionFilter(), JwtAuthenticationFilter.class)

                .httpBasic(HttpBasicConfigurer::disable)
                .csrf(CsrfConfigurer::disable)
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))

                .getOrBuild();
    }
}
