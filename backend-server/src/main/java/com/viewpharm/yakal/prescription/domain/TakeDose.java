package com.viewpharm.yakal.prescription.domain;

import com.viewpharm.yakal.base.type.EDosingTime;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Getter
@Setter
@DynamicUpdate
@NoArgsConstructor
@Table(name = "takedoses")
public class TakeDose {
    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dose_id", nullable = false)
    private Dose dose;

    @Column(name = "take_time", nullable = false)
    private EDosingTime dosingTime;

    @Column(name = "is_take",nullable = false)
    private boolean isTaken;

    public TakeDose(Dose dose, EDosingTime dosingTime, boolean isTaken) {
        this.dose = dose;
        this.dosingTime = dosingTime;
        this.isTaken = isTaken;
    }

    public void updateIsTaken(final Boolean isTaken) {
        this.isTaken = isTaken;
    }
}

