package com.viewpharm.yakal.domain;

import com.viewpharm.yakal.type.ELoginProvider;
import com.viewpharm.yakal.type.ERole;
import com.viewpharm.yakal.type.ESex;
import jakarta.persistence.Column;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@DynamicUpdate
@Table(name = "mobile_users")
@DiscriminatorValue("ROLE_MOBILE")
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

    /**
     * ONE-TO-MANY RELATION
     */
    @OneToMany(mappedBy = "mobileUser", fetch = FetchType.LAZY)
    private List<Prescription> prescriptions = new ArrayList<>();

    @OneToMany(mappedBy = "mobileUser", fetch = FetchType.LAZY)
    private List<Notification> notifications = new ArrayList<>();

    @OneToMany(mappedBy = "mobileUser", fetch = FetchType.LAZY)
    private List<Dose> doses = new ArrayList<>();

    @Builder
    public MobileUser(final String socialId,
                      final ELoginProvider loginProvider,
                      final ERole role,
                      final String name) {
        super(role, name);
        this.socialId = socialId;
        this.loginProvider = loginProvider;
        this.isLogin = true;
    }

    public void logout() {
        super.setRefreshToken(null);
        this.deviceToken = null;
        this.isLogin = false;
    }
}
