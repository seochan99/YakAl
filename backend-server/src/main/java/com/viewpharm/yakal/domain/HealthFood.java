package com.viewpharm.yakal.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;
//비타민으로 변경예정
@Deprecated
@Entity
@Getter
@Setter
@DynamicUpdate
@NoArgsConstructor
@Table(name = "healthfoods")
public class HealthFood {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    /* -------------------------------------------------- */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    public void modifyHealthFood(String name) {
        this.name = name;
    }

    @Builder
    public HealthFood(String name, User user) {
        this.name = name;
        this.user = user;
    }
}
