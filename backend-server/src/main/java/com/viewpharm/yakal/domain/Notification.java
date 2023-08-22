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
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
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

    @Column(name = "status", columnDefinition = "TINYINT(1)")
    private Boolean status;

    /* -------------------------------------------------- */

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    public void readNoti() {
        this.isRead = true;
    }

    public void deleteNofification() {
        this.status = false;
    }

    @Builder
    public Notification(String title, String content, Boolean isRead, Timestamp createdDate, Boolean status, User user) {
        this.title = title;
        this.content = content;
        this.isRead = false;
        this.createdDate = Timestamp.valueOf(LocalDateTime.now());
        this.status = true;
        this.user = user;
    }


}
