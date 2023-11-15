package com.viewpharm.yakal.desire.domain;

import com.viewpharm.yakal.user.domain.User;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.DynamicUpdate;

import java.time.LocalDate;

@Entity
@Getter
@DynamicUpdate
@Table(name = "desires")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Desire {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "content", nullable = false)
    private String content;

    @Column(name = "created_at", nullable = false)
    private LocalDate createdDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;


    @Builder
    public Desire(String content, User user) {
        this.content = content;
        this.user = user;
        this.createdDate = LocalDate.now();
    }
}
