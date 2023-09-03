package com.viewpharm.yakal.domain;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.DynamicUpdate;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@DynamicUpdate
@Table(name = "login_logs")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class LoginLog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "login_time", nullable = false)
    private LocalDate loginTime;

    //-------------------------------------------------------------------
    @Builder
    public LoginLog(LocalDate loginTime) {
        this.loginTime = loginTime;
    }
}
