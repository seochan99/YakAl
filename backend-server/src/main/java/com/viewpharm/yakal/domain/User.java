package com.viewpharm.yakal.domain;

import com.viewpharm.yakal.type.ERole;
import jakarta.persistence.Column;
import jakarta.persistence.DiscriminatorColumn;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;
import jakarta.persistence.Table;
import lombok.AccessLevel;
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
@Table(name = "users")
@DiscriminatorColumn(name="role")
@Inheritance(strategy = InheritanceType.JOINED)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class User {

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
    @Column(name = "name")
    private String name;

    @Column(name = "role", nullable = false)
    @Enumerated(EnumType.STRING)
    private ERole role;

    @Column(name = "created_date", nullable = false)
    private LocalDate createdDate;

    @Column(name="refresh_token")
    private String refreshToken;

    @Builder
    public User(final ERole role, final String name) {
        this.role = role;
        this.name = name;
        this.createdDate = LocalDate.now();
    }
}
