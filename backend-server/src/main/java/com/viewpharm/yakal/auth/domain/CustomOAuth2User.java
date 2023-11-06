package com.viewpharm.yakal.auth.domain;

import com.viewpharm.yakal.base.type.ERole;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;

import java.util.Collection;
import java.util.Map;

@Getter
public class CustomOAuth2User extends DefaultOAuth2User {

    private final String id;
    private final ERole role;

    public CustomOAuth2User(
            Collection<? extends GrantedAuthority> authorities,
            Map<String, Object> attributes,
            String nameAttributeKey, String id, ERole role) {
        super(authorities, attributes, nameAttributeKey);
        this.id = id;
        this.role = role;
    }
}

