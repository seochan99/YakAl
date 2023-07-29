package com.viewpharm.yakal.security;

import com.viewpharm.yakal.domain.User;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;
import java.util.Set;

@Getter
public class UserDetailForIdOnly implements UserDetails {

    private final Long id;
    private final Collection<? extends GrantedAuthority> authorities;
    private Map<String, Object> attributes;

    public UserDetailForIdOnly(final Long id, final Collection<? extends GrantedAuthority> authorities) {
        this.id = id;
        this.authorities = authorities;
    }

    public static UserDetailForIdOnly create(final User user) {
        final SimpleGrantedAuthority authority = new SimpleGrantedAuthority(user.getRole().toString());
        final Set<GrantedAuthority> authorities = Collections.singleton(authority);
        return new UserDetailForIdOnly(user.getId(), authorities);
    }

    public static UserDetailForIdOnly create(final User user, final Map<String, Object> attributes) {
        final UserDetailForIdOnly userDetails = UserDetailForIdOnly.create(user);
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