package com.viewpharm.yakal.domain;

import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

@Getter
public class CustomUserDetail implements UserDetails {
    private final Long id;
    private final Collection<? extends GrantedAuthority> authorities;
    private Map<String, Object> attributes;

    public CustomUserDetail(final Long id, final Collection<? extends GrantedAuthority> authorities) {
        this.id = id;
        this.authorities = authorities;
    }

    public static CustomUserDetail create(User user) {
        final List<GrantedAuthority> authorities = Collections.
                singletonList(new SimpleGrantedAuthority("ROLE_" + user.getUserRole()));

        return new CustomUserDetail(user.getId(), authorities);
    }

    public static CustomUserDetail create(final User user, final Map<String, Object> attributes) {
        final CustomUserDetail userDetails = CustomUserDetail.create(user);
        userDetails.setAttributes(attributes);
        return userDetails;
    }

    // UserDetail Override
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getUsername() {
        return String.valueOf(id);
    }

    @Override
    public String getPassword() {
        return null;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    public void setAttributes(final Map<String, Object> attributes) {
        this.attributes = attributes;
    }
}