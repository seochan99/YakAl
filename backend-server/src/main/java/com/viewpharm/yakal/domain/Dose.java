package com.viewpharm.yakal.domain;

import com.viewpharm.yakal.type.EDosingTime;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@DynamicUpdate
@NoArgsConstructor
@Table(name = "doses")
public class Dose {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    // 도훈: 개인적으로 약명과 성분명은 이름보다 코드가 더 다루기 편할 것 같다.
    @Column(name="pill_name", nullable = false)
    private String pillName;

    @Column(name="date", nullable = false)
    private LocalDate date;

    @Column(name="time", nullable = false)
    @Enumerated(EnumType.STRING)
    private EDosingTime time;

    @Column(name="is_taken", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isTaken;

    @Column(name="pill_cnt", nullable = false)
    private int pillCnt;

    // 반알을 먹어야 하면 True
    @Column(name="is_half", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isHalf;

    /* -------------------------------------------------- */

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="prescription_id", nullable = false)
    private Prescription prescription;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id", nullable = false)
    private User user;

    /* -------------------------------------------------- */
    @Builder
    public Dose(String pillName, LocalDate date, EDosingTime time, int pillCnt, Boolean isHalf, Prescription prescription,User user) {
        this.pillName = pillName;
        this.date = date;
        this.time = time;
        this.pillCnt = pillCnt;
        this.isHalf = isHalf;
        this.prescription = prescription;
        this.user=user;
        this.isTaken = false;
    }
}
