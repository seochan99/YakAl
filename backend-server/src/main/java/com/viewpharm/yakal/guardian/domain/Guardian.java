package com.viewpharm.yakal.guardian.domain;

import com.viewpharm.yakal.user.domain.User;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicUpdate;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Getter
@DynamicUpdate
@NoArgsConstructor
@Table(name = "guardians")
public class Guardian {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @JoinColumn(name = "patient_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private User patient;

    @JoinColumn(name = "guardian_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private User guardian;

    @Column(name = "created_at")
    private Timestamp createdDate;

    @Builder
    public Guardian(User patient, User guardian, Timestamp createdDate) {
        this.patient = patient;
        this.guardian = guardian;
        this.createdDate = Timestamp.valueOf(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
    }
}
