package com.viewpharm.yakal.domain;

import com.viewpharm.yakal.type.EDosingTime;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import java.sql.Timestamp;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@DynamicUpdate
@NoArgsConstructor
@Table(name = "doses")
@Where(clause = "deleted_at is null")
@SQLDelete(sql = "update doses set deleted_at = now() where id = ?")
public class Dose {

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
    @Column(name = "kd_code", nullable = false)
    private String KDCode;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "risks_id")
    private Risk ATCCode;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dosename_id")
    private DoseName doseName;

    @Column(name = "date", nullable = false)
    private LocalDate date;

    @Column(name = "time", nullable = false)
    @Enumerated(EnumType.STRING)
    private EDosingTime time;

    @Column(name = "is_taken", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isTaken;

    @Column(name = "pill_cnt", nullable = false)
    private Long pillCnt;

    @Column(name = "is_half", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isHalf;

    @Column(name = "is_deleted", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isDeleted;

    @Column(name = "created_at", nullable = false)
    private Timestamp created;

    @Column(name = "deleted_at")
    private Timestamp deleted;

    /**
     * MANY-TO-ONE RELATION
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "prescription_id", nullable = false)
    private Prescription prescription;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Builder
    public Dose(final String kdCode,
                final Risk ATCCode,
                final LocalDate date,
                final EDosingTime time,
                final Long pillCnt,
                final Boolean isHalf,
                final Prescription prescription,
                final User user,
                final DoseName doseName) {
        this.KDCode = kdCode;
        this.date = date;
        this.time = time;
        this.pillCnt = pillCnt;
        this.isHalf = isHalf;
        this.prescription = prescription;
        this.user = user;
        this.isTaken = false;
        this.isDeleted = false;
        this.ATCCode = ATCCode;
        this.created = new Timestamp(System.currentTimeMillis());
        this.doseName = doseName;
    }

    public void updateIsTaken(final Boolean isTaken) {
        this.isTaken = isTaken;
    }
}