package com.viewpharm.yakal.domain;

import com.viewpharm.yakal.type.EImageUseType;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "images")
@DynamicUpdate
public class Image {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @JoinColumn(name = "use_user")
    @OneToOne(fetch = FetchType.LAZY)
    private User user;

    @JoinColumn(name = "use_medical")
    @OneToOne(fetch = FetchType.LAZY)
    private Medical medical;

    @JoinColumn(name = "expert_id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Expert expert;

    @JoinColumn(name = "registration_id")
    @OneToOne(fetch = FetchType.LAZY)
    private Registration registration;

    @Column(name = "uuid_name", columnDefinition = "CHAR(41)", nullable = false)
    private String uuidName;

    @Column(name = "type", nullable = false)
    private String type;

    @Column(name = "path", nullable = false)
    private String path;

    @Builder
    public Image(Object useObject, EImageUseType imageUseType, String uuidName, String type, String path) {
        switch (imageUseType) {
            case USER -> {
                this.user = (User) useObject;
                this.medical = null;
                this.expert = null;
                this.registration = null;
            }
            case MEDICAL -> {
                this.medical = (Medical) useObject;
                this.user = null;
                this.expert = null;
                this.registration = null;
            }
            case EXPERT -> {
                this.expert = (Expert) useObject;
                this.user = null;
                this.medical = null;
                this.registration = null;
            }
            case REGISTER -> {
                this.registration = (Registration) useObject;
                this.user = null;
                this.expert = null;
                this.medical = null;
            }
        }
        this.uuidName = uuidName;
        this.type = type;
        this.path = path;
    }

    public void updateImage(String uuidName, String type, String path) {
        setUuidName(uuidName);
        setType(type);
        setPath(path);
    }
}