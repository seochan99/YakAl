package com.viewpharm.yakal.medicalappointment.domain;

import com.viewpharm.yakal.domain.BaseCreateEntity;
import com.viewpharm.yakal.domain.User;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "medical_appointments")
@Where(clause = "is_deleted = false")
@SQLDelete(sql = "update medical_appointments set is_deleted = true where id = ?")
public class MedicalAppointment extends BaseCreateEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @JoinColumn(name = "patient_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private User patient;

    @JoinColumn(name = "expert_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private User expert;

    @Column(name = "expired_date", nullable = false)
    private Timestamp expiredDate;

    @Column(name = "is_deleted", nullable = false)
    private Boolean isDeleted;

    @Builder
    public MedicalAppointment(User patient, User expert) {
        this.patient = patient;
        this.expert = expert;
        this.expiredDate = Timestamp.valueOf(LocalDateTime.now().plusHours(6));
        this.isDeleted = false;
    }
}
