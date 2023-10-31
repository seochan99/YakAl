package com.viewpharm.yakal.user.domain;

import com.viewpharm.yakal.domain.BaseCreateEntity;
import com.viewpharm.yakal.domain.Image;
import com.viewpharm.yakal.domain.Medical;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "experts")
public class Expert extends BaseCreateEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    // 관리자에 의해 처리됬는지 Default False
    @Column
    private Boolean isProcessed = Boolean.FALSE;

    @JoinColumn(name = "use_user")
    @OneToOne(fetch = FetchType.LAZY)
    private User user;

    @JoinColumn(name = "use_medical")
    @OneToOne(fetch = FetchType.LAZY)
    private Medical medical;

    @OneToMany(mappedBy = "expert", fetch = FetchType.LAZY)
    private List<Image> images;


    @Builder
    public Expert(User user) {
        this.user = user;
    }
}
