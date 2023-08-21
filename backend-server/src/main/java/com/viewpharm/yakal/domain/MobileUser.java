package com.viewpharm.yakal.domain;

import com.viewpharm.yakal.type.ELoginProvider;
import com.viewpharm.yakal.type.ERole;
import com.viewpharm.yakal.type.ESex;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@DynamicUpdate
@Table(name = "mobile_users")
@PrimaryKeyJoinColumn(name="user_id")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MobileUser extends User {

    @Column(name = "social_id", nullable = false)
    private String socialId;

    @Column(name = "login_provider", nullable = false)
    @Enumerated(EnumType.STRING)
    private ELoginProvider loginProvider;

    @Column(name = "birthday")
    private LocalDate birthday;

    @Column(name = "sex")
    @Enumerated(EnumType.STRING)
    private ESex sex;

    @Column(name = "device_token")
    private String deviceToken;

    @Column(name = "is_login", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isLogin;

    @Column(name = "is_ios", columnDefinition = "TINYINT(1)")
    private Boolean isIos;

    @Column(name = "is_detail", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isDetail;

    @Column(name = "is_allowed_notification", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isAllowedNotification;

    @Column(name = "breakfastTime")
    private LocalTime breakfastTime;

    @Column(name = "lunchTime")
    private LocalTime lunchTime;

    @Column(name = "dinnerTime")
    private LocalTime dinnerTime;

    /**
     * ONE-TO-ONE RELATION
     */

    @OneToOne(mappedBy = "user", fetch = FetchType.LAZY)
    private Image image;

    /**
     * ONE-TO-MANY RELATION
     */
    @OneToMany(mappedBy = "mobileUser", fetch = FetchType.LAZY)
    private List<Prescription> prescriptions = new ArrayList<>();

    @OneToMany(mappedBy = "mobileUser", fetch = FetchType.LAZY)
    private List<Notification> notifications = new ArrayList<>();

    @OneToMany(mappedBy = "mobileUser", fetch = FetchType.LAZY)
    private List<Dose> doses = new ArrayList<>();

    public MobileUser(final String socialId,
                      final ELoginProvider loginProvider,
                      final ERole role) {
        super(role);
        this.socialId = socialId;
        this.loginProvider = loginProvider;
        this.isLogin = true;
        this.isDetail = true;
        this.isAllowedNotification = true;
    }

    public void logout() {
        super.setRefreshToken(null);
        this.deviceToken = null;
        this.isLogin = false;
    }
}
