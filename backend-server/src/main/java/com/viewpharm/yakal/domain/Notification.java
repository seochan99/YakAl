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
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicUpdate;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Entity
@Getter
@DynamicUpdate
@NoArgsConstructor

@Table(name = "notifications")

public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "content", nullable = false)
    private String content;

    @Column(name = "is_read", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isRead;

    @Column(name = "create_date", nullable = false)
    private Timestamp createdDate;

    /* -------------------------------------------------- */

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private MobileUser mobileUser;

    @Builder
    public Notification(final String title,
                        final String content,
                        final MobileUser mobileUser) {
        this.title = title;
        this.content = content;
        this.isRead = false;
        this.createdDate = Timestamp.valueOf(LocalDateTime.now());
        this.mobileUser = mobileUser;
    }
}
