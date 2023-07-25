package com.viewpharm.yakal.domain;

import com.viewpharm.yakal.type.EJob;
import com.viewpharm.yakal.type.ESex;
import com.viewpharm.yakal.type.EUserRole;
import com.viewpharm.yakal.type.ELoginProvider;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@DynamicUpdate
@NoArgsConstructor
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "social_id", nullable = false)
    private String socialId;

    @Column(name = "login_provider", nullable = false)
    @Enumerated(EnumType.STRING)
    private ELoginProvider loginProvider;

    @Column(name = "name")
    private String name;

    @Column(name = "tel")
    private String tel;

    @Column(name = "birthday")
    private LocalDate birthday;

    @Column(name = "sex")
    @Enumerated(EnumType.STRING)
    private ESex sex;

    @Column(name = "role", nullable = false)
    @Enumerated(EnumType.STRING)
    private EUserRole userRole;

    @Column(name = "job")
    @Enumerated(EnumType.STRING)
    private EJob job;

    @Column(name = "created_date", nullable = false)
    private LocalDate createdDate;

    @Column(name = "refresh_token", nullable = false)
    private String refreshToken;

    @Column(name = "device_token")
    private String deviceToken;

    @Column(name = "is_login", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isLogin;

    @Column(name = "is_ios", columnDefinition = "TINYINT(1)")
    private Boolean isIos;

    @Column(name = "expiration_date")
    private Timestamp expirationDate;

    /* -------------------------------------------------- */

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Prescription> prescriptions = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Notification> notifications = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Dose> doses = new ArrayList<>();

    /* -------------------------------------------------- */

    @Builder
    public User(final String socialId,
                final ELoginProvider loginProvider,
                final EUserRole userRole,
                final String refreshToken) {
        this.socialId = socialId;
        this.loginProvider = loginProvider;
        this.userRole = userRole;
        this.createdDate = LocalDate.now();
        this.refreshToken = refreshToken;
        this.isLogin = true;
    }
}
