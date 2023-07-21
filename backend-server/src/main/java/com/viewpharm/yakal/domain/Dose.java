package com.viewpharm.yakal.domain;

import com.viewpharm.yakal.type.EDosingTime;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
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

import java.time.LocalDate;

@Entity
@Getter
@Setter
@DynamicUpdate
@NoArgsConstructor
@Table(name = "doses")
public class Dose {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    // 도훈: 개인적으로 약명과 성분명은 이름보다 코드가 더 다루기 편할 것 같다.
    @Column(name="medicine", nullable = false)
    private String medicine;

    @Column(name="ingredient", nullable = false)
    private String ingredient;

    @Column(name="date", nullable = false)
    private LocalDate date;

    @Column(name="time", nullable = false)
    @Enumerated(EnumType.STRING)
    private EDosingTime time;

    @Column(name="is_taken", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isTaken;

    // 도훈: 0.5정 처방에 대응하기 위해 Float 을 넣기보다 0.5정의 개수를 넣는 방안
    @Column(name="half_pill_count", nullable = false)
    private Integer halfPillCount;

    /* -------------------------------------------------- */

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="prescription_id", nullable = false)
    private Prescription prescription;

    /* -------------------------------------------------- */

    @Builder
    public Dose(final Prescription prescription,
                final String medicine,
                final String ingredient,
                final LocalDate date,
                final EDosingTime time,
                final Integer halfPillCount) {
        this.prescription = prescription;
        this.medicine = medicine;
        this.ingredient = ingredient;
        this.date = date;
        this.time = time;
        this.isTaken = false;
        this.halfPillCount = halfPillCount;
    }
}
