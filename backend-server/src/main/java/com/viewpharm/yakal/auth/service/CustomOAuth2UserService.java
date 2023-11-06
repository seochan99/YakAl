package com.viewpharm.yakal.auth.service;

import com.viewpharm.yakal.auth.domain.OAuth2UserInfo;
import com.viewpharm.yakal.auth.domain.OAuth2UserInfoFactory;
import com.viewpharm.yakal.auth.domain.UserPrincipal;
import com.viewpharm.yakal.base.type.ELoginProvider;
import com.viewpharm.yakal.base.type.ERole;
import com.viewpharm.yakal.prescription.domain.Prescription;
import com.viewpharm.yakal.prescription.repository.PrescriptionRepository;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService extends DefaultOAuth2UserService {
    private final UserRepository userRepository;
    private final PrescriptionRepository prescriptionRepository;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) {
        OAuth2User oauth2User = super.loadUser(userRequest);
        try {
            return this.process(userRequest, oauth2User);
        } catch (Exception ex) {
            throw new InternalAuthenticationServiceException(ex.getMessage(), ex.getCause());
        }
    }

    private OAuth2User process(OAuth2UserRequest userRequest, OAuth2User oauth2User) {
        ELoginProvider provider = ELoginProvider.valueOf(userRequest.getClientRegistration().getRegistrationId().toUpperCase());
        OAuth2UserInfo userInfo = OAuth2UserInfoFactory.getOAuth2UserInfo(provider, oauth2User.getAttributes());

        Optional<User> userOpt = userRepository.findBySocialIdAndLoginProvider(userInfo.getId(), provider);

        User user = null;

        if (userOpt.isEmpty()) {
            user = userRepository.save(User.builder()
                    .socialId(userInfo.getId())
                    .loginProvider(provider)
                    .role(ERole.USER)
                    .build());

            prescriptionRepository.save(
                    Prescription.builder()
                            .user(user)
                            .pharmacyName("default")
                            .prescribedDate(LocalDate.now())
                            .build());
        } else {
            user = userOpt.get();
        }

        return UserPrincipal.create(user, oauth2User.getAttributes());
    }
}
