package com.viewpharm.yakal.medicalappointment.domain;

import com.viewpharm.yakal.domain.BaseCreateEntity;
import com.viewpharm.yakal.user.domain.User;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

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

    @Column(name = "is_deleted", nullable = false)
    private Boolean isDeleted;

    @Builder
    public MedicalAppointment(User patient, User expert) {
        this.patient = patient;
        this.expert = expert;
        this.isDeleted = false;
    }
}
