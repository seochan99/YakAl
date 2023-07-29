package com.viewpharm.yakal.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QDose is a Querydsl query type for Dose
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QDose extends EntityPathBase<Dose> {

    private static final long serialVersionUID = 1669286347L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QDose dose = new QDose("dose");

    public final StringPath ATCCode = createString("ATCCode");

    public final DateTimePath<java.sql.Timestamp> created = createDateTime("created", java.sql.Timestamp.class);

    public final DatePath<java.time.LocalDate> date = createDate("date", java.time.LocalDate.class);

    public final DateTimePath<java.sql.Timestamp> deleted = createDateTime("deleted", java.sql.Timestamp.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final BooleanPath isDeleted = createBoolean("isDeleted");

    public final BooleanPath isHalf = createBoolean("isHalf");

    public final BooleanPath isTaken = createBoolean("isTaken");

    public final StringPath KDCode = createString("KDCode");

    public final QMobileUser mobileUser;

    public final NumberPath<Long> pillCnt = createNumber("pillCnt", Long.class);

    public final QPrescription prescription;

    public final EnumPath<com.viewpharm.yakal.type.EDosingTime> time = createEnum("time", com.viewpharm.yakal.type.EDosingTime.class);

    public QDose(String variable) {
        this(Dose.class, forVariable(variable), INITS);
    }

    public QDose(Path<? extends Dose> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QDose(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QDose(PathMetadata metadata, PathInits inits) {
        this(Dose.class, metadata, inits);
    }

    public QDose(Class<? extends Dose> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.mobileUser = inits.isInitialized("mobileUser") ? new QMobileUser(forProperty("mobileUser")) : null;
        this.prescription = inits.isInitialized("prescription") ? new QPrescription(forProperty("prescription"), inits.get("prescription")) : null;
    }

}

