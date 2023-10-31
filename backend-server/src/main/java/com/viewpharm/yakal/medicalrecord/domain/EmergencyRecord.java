package com.viewpharm.yakal.medicalrecord.domain;

import com.viewpharm.yakal.domain.User;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Entity
@Getter
@NoArgsConstructor
@Table(name = "emergency_records")
public class EmergencyRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "hospital_name", nullable = false)
    private String hospitalName;


    @Column(name = "date", nullable = false)
    private Date date;

    /* -------------------------------------------------- */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Builder
    public EmergencyRecord(String hospitalName, Date date, User user) {
        this.hospitalName = hospitalName;
        this.date = date;
        this.user = user;
    }
}
