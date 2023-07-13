package com.viewpharm.yakal.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Getter
@Setter
@Table(name = "users")
@DynamicUpdate
@NoArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "social_id")
    private String socialId;

    @Column(name = "provider")
    @Enumerated(EnumType.STRING)
    private LoginProvider provider;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "introduction")
    private String introduction;

    @Column(name = "role")
    @Enumerated(EnumType.STRING)
    private UserRole role;

    @Column(name = "is_login", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isLogin;

    @Column(name = "refresh_Token")
    private String refreshToken;

    @Column(name = "device_Token")
    private String deviceToken;

    @Column(name = "isIOS", columnDefinition = "TINYINT(1)")
    private Boolean isIos;


    @Builder
    public User(String socialId, LoginProvider provider, String name, UserRole role,
                String refreshToken) {
        this.socialId = socialId;
        this.provider = provider;
        this.role = role;
        this.isLogin = true;
        this.refreshToken = refreshToken;
        this.deviceToken = null;
        this.isIos = null;
    }
}