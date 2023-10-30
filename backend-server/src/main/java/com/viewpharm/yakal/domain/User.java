package com.viewpharm.yakal.domain;

import com.viewpharm.yakal.notablefeatures.domain.*;
import com.viewpharm.yakal.base.type.EJob;
import com.viewpharm.yakal.base.type.ELoginProvider;
import com.viewpharm.yakal.base.type.ERole;
import com.viewpharm.yakal.base.type.ESex;
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

    // 하이픈("-") 없이
    @Column(name = "tel")
    private String tel;

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

    //초기 직업은 환자로 설정
    @Column(name = "job")
    @Enumerated(EnumType.STRING)
    private EJob job = EJob.PATIENT;

    // 추후에 Enum화 해도 괜찮을듯 아직 전공 종류나 개수를 모름
    @Column(name = "department")
    private String department;

    // 인증 여부
    @Column(name = "is_identified", columnDefinition = "TINYINT(1)")
    private Boolean isIdentified;

    //의사 약사 영양사 인증 여부
    @Column(name = "is_certified")
    private Boolean isCertified;


    /**
     * ONE-TO-ONE RELATION
     */
    @OneToOne(mappedBy = "user", fetch = FetchType.LAZY)
    private Image image;

    @OneToOne(mappedBy = "user", fetch = FetchType.LAZY)
    private Expert expert;


    /**
     * ONE-TO-MANY RELATION
     */
    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Prescription> prescriptions = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Dose> doses = new ArrayList<>();

    @OneToMany(mappedBy = "expert", fetch = FetchType.LAZY)
    private List<Counsel> counselForExpert = new ArrayList<>();

    @OneToMany(mappedBy = "patient", fetch = FetchType.LAZY)
    private List<Counsel> counselForPatient = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Answer> answers = new ArrayList<>();

    @OneToMany(mappedBy = "patient", fetch = FetchType.LAZY)
    private List<Guardian> protectedPerson;

    @OneToMany(mappedBy = "guardian", fetch = FetchType.LAZY)
    private List<Guardian> myGuardian;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<UnderlyingCondition> underlyingConditions = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<MedicalHistory> medicalHistories = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<DietarySupplement> dietarySupplements = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Allergy> allergies = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Fall> falls = new ArrayList<>();

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
        this.isIdentified = false;
        this.breakfastTime = LocalTime.of(9,0,0);
        this.lunchTime = LocalTime.of(13,0,0);
        this.dinnerTime = LocalTime.of(18,0,0);
    }

    public void updateDevice(String deviceToken, Boolean isIos) {
        this.deviceToken = deviceToken;
        this.isIos = isIos;
    }

    public void logout() {
        setRefreshToken(null);
        this.deviceToken = null;
        this.isLogin = false;
    }
}
