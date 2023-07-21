package com.viewpharm.yakal.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

import java.sql.Timestamp;

@Entity
@Getter
@Setter
@DynamicUpdate
@NoArgsConstructor
@Table(name = "doses")
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name="title", nullable = false)
    private String title;

    @Column(name="description", nullable = false)
    private String description;

    @Column(name="is_read", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isRead;

    @Column(name="created_at", nullable = false)
    private Timestamp created;

    /* -------------------------------------------------- */

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id", nullable = false)
    private User user;
}
