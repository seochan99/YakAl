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
@Table(name = "users")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class User {

    /**
     * PK
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    /**
     * COLUMNS
     */
    @Column(name = "name", columnDefinition = "CHAR(20)")
    private String name;

    @Column(name = "role", nullable = false)
    @Enumerated(EnumType.STRING)
    private ERole role;

    @Column(name = "created_date", nullable = false)
    private LocalDate createdDate;

    @Column(name = "refresh_token")
    private String refreshToken;

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

    @Column(name = "noti_is_allowed", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean notiIsAllowed;

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
    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Prescription> prescriptions = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Notification> notifications = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Dose> doses = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Board> board = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Like> likes = new ArrayList<>();

    public User(final String socialId,
                final ELoginProvider loginProvider,
                final ERole role,
                final Image image) {
        this.role = role;
        this.createdDate = LocalDate.now();
        this.socialId = socialId;
        this.loginProvider = loginProvider;
        this.isLogin = true;
        this.isDetail = true;
        this.notiIsAllowed = true;
        this.image = image;
    }

    public void logout() {
        setRefreshToken(null);
        this.deviceToken = null;
        this.isLogin = false;
    }
}
