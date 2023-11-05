package com.viewpharm.yakal.base;

import jakarta.persistence.Column;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.MappedSuperclass;
import lombok.Getter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDate;

@EntityListeners(AuditingEntityListener.class)
@MappedSuperclass
@Getter
public class BaseCreateEntity {
    @CreatedDate
    @Column(updatable = false, nullable = false)
    private LocalDate createDate;

    @LastModifiedDate
    private LocalDate lastModifiedDate;

}