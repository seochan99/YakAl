package com.viewpharm.yakal.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QMobileUser is a Querydsl query type for MobileUser
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QMobileUser extends EntityPathBase<MobileUser> {

    private static final long serialVersionUID = 1676835515L;

    public static final QMobileUser mobileUser = new QMobileUser("mobileUser");

    public final QUser _super = new QUser(this);

    public final DatePath<java.time.LocalDate> birthday = createDate("birthday", java.time.LocalDate.class);

    public final TimePath<java.time.LocalTime> breakfastTime = createTime("breakfastTime", java.time.LocalTime.class);

    //inherited
    public final DatePath<java.time.LocalDate> createdDate = _super.createdDate;

    public final StringPath deviceToken = createString("deviceToken");

    public final TimePath<java.time.LocalTime> dinnerTime = createTime("dinnerTime", java.time.LocalTime.class);

    public final ListPath<Dose, QDose> doses = this.<Dose, QDose>createList("doses", Dose.class, QDose.class, PathInits.DIRECT2);

    //inherited
    public final NumberPath<Long> id = _super.id;

    public final BooleanPath isAllowedNotification = createBoolean("isAllowedNotification");

    public final BooleanPath isDetail = createBoolean("isDetail");

    public final BooleanPath isIos = createBoolean("isIos");

    public final BooleanPath isLogin = createBoolean("isLogin");

    public final EnumPath<com.viewpharm.yakal.type.ELoginProvider> loginProvider = createEnum("loginProvider", com.viewpharm.yakal.type.ELoginProvider.class);

    public final TimePath<java.time.LocalTime> lunchTime = createTime("lunchTime", java.time.LocalTime.class);

    //inherited
    public final StringPath name = _super.name;

    public final ListPath<Notification, QNotification> notifications = this.<Notification, QNotification>createList("notifications", Notification.class, QNotification.class, PathInits.DIRECT2);

    public final ListPath<Prescription, QPrescription> prescriptions = this.<Prescription, QPrescription>createList("prescriptions", Prescription.class, QPrescription.class, PathInits.DIRECT2);

    //inherited
    public final StringPath refreshToken = _super.refreshToken;

    //inherited
    public final EnumPath<com.viewpharm.yakal.type.ERole> role = _super.role;

    public final EnumPath<com.viewpharm.yakal.type.ESex> sex = createEnum("sex", com.viewpharm.yakal.type.ESex.class);

    public final StringPath socialId = createString("socialId");

    public QMobileUser(String variable) {
        super(MobileUser.class, forVariable(variable));
    }

    public QMobileUser(Path<? extends MobileUser> path) {
        super(path.getType(), path.getMetadata());
    }

    public QMobileUser(PathMetadata metadata) {
        super(MobileUser.class, metadata);
    }

}

