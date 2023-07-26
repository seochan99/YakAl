package com.viewpharm.yakal.config;

import com.viewpharm.yakal.common.Constants;
import com.viewpharm.yakal.security.UserDetailServiceForLoad;
import com.viewpharm.yakal.security.JwtAuthenticationFilter;
import com.viewpharm.yakal.security.JwtExceptionFilter;
import com.viewpharm.yakal.security.JwtAccessDenied;
import com.viewpharm.yakal.security.JwtAuthEntryPoint;
import com.viewpharm.yakal.security.JwtProvider;
import com.viewpharm.yakal.type.ERole;
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

    private final JwtProvider jwtProvider;
    private final UserDetailServiceForLoad userDetailServiceForLoad;
    private final JwtAuthEntryPoint jwtAuthEntryPoint;
    private final JwtAccessDenied jwtAccessDeniedHandler;

    @Bean
    protected SecurityFilterChain securityFilterChain(final HttpSecurity httpSecurity) throws Exception {
        return httpSecurity
                .authorizeHttpRequests(requestMatcherRegistry -> requestMatcherRegistry.anyRequest().permitAll())
                .authorizeHttpRequests(requestMatcherRegistry -> requestMatcherRegistry
                        .requestMatchers(Constants.NO_NEED_AUTH_URLS).permitAll()
                        .requestMatchers("/admin/**").hasRole(ERole.ROLE_WEB.toString())
                        .anyRequest().authenticated())

                .exceptionHandling(exception -> exception.authenticationEntryPoint(jwtAuthEntryPoint))
                .exceptionHandling(exception -> exception.accessDeniedHandler(jwtAccessDeniedHandler))

                .addFilterBefore(new JwtExceptionFilter(), JwtAuthenticationFilter.class)
                .addFilterBefore(new JwtAuthenticationFilter(jwtProvider, userDetailServiceForLoad), UsernamePasswordAuthenticationFilter.class)

                .httpBasic(HttpBasicConfigurer::disable)
                .csrf(CsrfConfigurer::disable)
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))

                .getOrBuild();
    }
}
