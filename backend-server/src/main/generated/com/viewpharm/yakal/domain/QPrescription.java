package com.viewpharm.yakal.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QPrescription is a Querydsl query type for Prescription
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QPrescription extends EntityPathBase<Prescription> {

    private static final long serialVersionUID = -649184312L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QPrescription prescription = new QPrescription("prescription");

    public final DatePath<java.time.LocalDate> createdDate = createDate("createdDate", java.time.LocalDate.class);

    public final ListPath<Dose, QDose> doses = this.<Dose, QDose>createList("doses", Dose.class, QDose.class, PathInits.DIRECT2);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final QMobileUser mobileUser;

    public final StringPath pharmacyName = createString("pharmacyName");

    public final DatePath<java.time.LocalDate> prescribedDate = createDate("prescribedDate", java.time.LocalDate.class);

    public QPrescription(String variable) {
        this(Prescription.class, forVariable(variable), INITS);
    }

    public QPrescription(Path<? extends Prescription> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QPrescription(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QPrescription(PathMetadata metadata, PathInits inits) {
        this(Prescription.class, metadata, inits);
    }

    public QPrescription(Class<? extends Prescription> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.mobileUser = inits.isInitialized("mobileUser") ? new QMobileUser(forProperty("mobileUser")) : null;
    }

}

