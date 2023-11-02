package com.viewpharm.yakal.prescription.domain;

import com.viewpharm.yakal.user.domain.User;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.DynamicUpdate;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@DynamicUpdate
@NoArgsConstructor
@Table(name = "prescriptions")
public class Prescription {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    // 도훈: 9월 이후에 제휴 약국 테이블을 join 하는 방안
    @Column(name = "pharmacy_name", nullable = false)
    private String pharmacyName;

    //처방 날짜
    @Column(name = "prescribed_date", nullable = false)
    private LocalDate prescribedDate;

    @CreationTimestamp
    @Column(name = "created_date", nullable = false)
    private LocalDate createdDate;

    // 전문가들이 처방전을 볼 수 있는 권한
    @Column
    private Boolean isAllow;


    /* -------------------------------------------------- */

    @OneToMany(mappedBy = "prescription", fetch=FetchType.LAZY)
    private List<Dose> doses = new ArrayList<>();

    /* -------------------------------------------------- */

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id", nullable = false)
    private User user;

    /* -------------------------------------------------- */

    @Builder
    public Prescription(final User user, final String pharmacyName, final LocalDate prescribedDate,final Boolean isAllow) {
        this.user = user;
        this.pharmacyName = pharmacyName;
        this.prescribedDate = prescribedDate;
        this.isAllow = isAllow;
    }
}
