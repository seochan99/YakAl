package com.viewpharm.yakal.user.domain;

import com.viewpharm.yakal.medicalestablishment.domain.ExpertCertification;
import com.viewpharm.yakal.medicalestablishment.domain.MedicalEstablishment;
import com.viewpharm.yakal.survey.domain.Answer;
import com.viewpharm.yakal.prescription.domain.Dose;
import com.viewpharm.yakal.prescription.domain.Prescription;
import com.viewpharm.yakal.guardian.domain.Guardian;
import com.viewpharm.yakal.medicalappointment.domain.MedicalAppointment;
import com.viewpharm.yakal.medicalrecord.domain.HospitalizationRecord;
import com.viewpharm.yakal.notablefeature.domain.*;
import com.viewpharm.yakal.base.type.EJob;
import com.viewpharm.yakal.base.type.ELoginProvider;
import com.viewpharm.yakal.base.type.ERole;
import com.viewpharm.yakal.base.type.ESex;
import jakarta.persistence.*;
import lombok.*;
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
     * UNIQUE COMPOSITION KEY
     */
    @Column(name = "social_id", nullable = false)
    private String socialId;

    @Column(name = "login_provider", nullable = false)
    @Enumerated(EnumType.STRING)
    private ELoginProvider loginProvider;

    @Column(name = "role", nullable = false)
    @Enumerated(EnumType.STRING)
    private ERole role;

    /**
     * COLUMNS
     */

    @Column(name = "refresh_token")
    private String refreshToken;

    @Column(name = "device_token")
    private String deviceToken;

    @Column(name = "is_login", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isLogin;

    @Column(name = "name", columnDefinition = "CHAR(20)")
    private String name;

    @Column(name = "nickname", columnDefinition = "CHAR(20)")
    private String nickname;

    @Column(name = "department")
    private String department;

    @Column(name = "created_date", nullable = false)
    private LocalDate createdDate;

    @Column(name = "birthday")
    private LocalDate birthday;

    @Column(name = "tel")
    private String tel;

//    @Column(name = "sex")
//    @Enumerated(EnumType.STRING)
//    private ESex sex;

    /**
     * Optional Columns
     */

    @Column(name = "is_detail", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isDetail;

    @Column(name = "noti_is_allowed", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean notiIsAllowed;

    @Column(name = "breakfastTime", nullable = false)
    private LocalTime breakfastTime;

    @Column(name = "lunchTime", nullable = false)
    private LocalTime lunchTime;

    @Column(name = "dinnerTime", nullable = false)
    private LocalTime dinnerTime;

    @Column(name = "is_optional_agreement_accepted")
    private Boolean isOptionalAgreementAccepted;

    // 인증 여부
    @Column(name = "is_identified", columnDefinition = "TINYINT(1)")
    private Boolean isIdentified;

    @Column(name = "profile_img")
    private String profileImg = "0_default_profile.png";

    /**
     * MANY-TO-ONE RELATION
     */

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medical_establishment_id")
    private MedicalEstablishment medicalEstablishment;


    /**
     * ONE-TO-MANY RELATION
     */
    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<ExpertCertification> expertCertifications = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Prescription> prescriptions = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Dose> doses = new ArrayList<>();

    @OneToMany(mappedBy = "expert", fetch = FetchType.LAZY)
    private List<MedicalAppointment> medicalAppointmentForExpert = new ArrayList<>();

    @OneToMany(mappedBy = "patient", fetch = FetchType.LAZY)
    private List<MedicalAppointment> medicalAppointmentForPatient = new ArrayList<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Answer> answers = new ArrayList<>();

    @OneToMany(mappedBy = "patient", fetch = FetchType.LAZY)
    private List<Guardian> protectedPerson;

    @OneToMany(mappedBy = "guardian", fetch = FetchType.LAZY)
    private List<Guardian> myGuardian;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<HospitalizationRecord> hospitalizationRecords = new ArrayList<>();

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

    @Builder
    public User(final String socialId,
                final ELoginProvider loginProvider,
                final ERole role) {
        this.role = role;
        this.createdDate = LocalDate.now();
        this.socialId = socialId;
        this.loginProvider = loginProvider;
        this.isLogin = true;
        this.isDetail = true;
        this.notiIsAllowed = true;
        this.isIdentified = false;
        this.isOptionalAgreementAccepted = null;
        this.breakfastTime = LocalTime.of(9,0,0);
        this.lunchTime = LocalTime.of(13,0,0);
        this.dinnerTime = LocalTime.of(18,0,0);
    }

    public void updateIsOptionalAgreementAccepted(Boolean isOptionalAgreementAccepted) {
        this.isOptionalAgreementAccepted = isOptionalAgreementAccepted;
    }

    public void updateDevice(String deviceToken) {
        this.deviceToken = deviceToken;
    }

    public void updateBreakfastNotificationTime(LocalTime breakfastTime) {
        this.breakfastTime = breakfastTime;
    }

    public void updateLunchNotificationTime(LocalTime lunchTime) {
        this.lunchTime = lunchTime;
    }

    public void updateDinnerNotificationTime(LocalTime dinnerTime) {
        this.dinnerTime = dinnerTime;
    }

    public void logout() {
        setRefreshToken(null);
        this.deviceToken = null;
        this.isLogin = false;
    }
}
