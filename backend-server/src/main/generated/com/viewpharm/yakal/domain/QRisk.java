package com.viewpharm.yakal.domain;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;


/**
 * QRisk is a Querydsl query type for Risk
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QRisk extends EntityPathBase<Risk> {

    private static final long serialVersionUID = 1669697661L;

    public static final QRisk risk = new QRisk("risk");

    public final StringPath id = createString("id");

    public final NumberPath<Integer> score = createNumber("score", Integer.class);

    public QRisk(String variable) {
        super(Risk.class, forVariable(variable));
    }

    public QRisk(Path<? extends Risk> path) {
        super(path.getType(), path.getMetadata());
    }

    public QRisk(PathMetadata metadata) {
        super(Risk.class, metadata);
    }

}

