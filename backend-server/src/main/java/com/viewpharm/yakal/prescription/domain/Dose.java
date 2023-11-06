package com.viewpharm.yakal.prescription.domain;

import com.viewpharm.yakal.base.type.EDosingTime;
import com.viewpharm.yakal.user.domain.User;
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
import java.util.ArrayList;
import java.util.List;

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

    @Column(name = "date", nullable = false)
    private LocalDate date;

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

    @OneToMany(mappedBy = "dose", fetch = FetchType.LAZY)
    private List<TakeDose> takeDoses = new ArrayList<>();

    /**
     * MANY-TO-ONE RELATION
     */

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dosename_id")
    private DoseName KDCode;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "risk_id")
    private Risk ATCCode;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "prescription_id", nullable = false)
    private Prescription prescription;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Builder
    public Dose(final DoseName kdCode,
                final Risk atcCode,
                final LocalDate date,
                final Long pillCnt,
                final Boolean isHalf,
                final Prescription prescription,
                final User user) {
        this.KDCode = kdCode;
        this.ATCCode = atcCode;
        this.date = date;
        this.pillCnt = pillCnt;
        this.isHalf = isHalf;
        this.prescription = prescription;
        this.user = user;
        this.isDeleted = false;
        this.created = new Timestamp(System.currentTimeMillis());
    }


}