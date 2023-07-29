package com.viewpharm.yakal.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;
import static com.viewpharm.yakal.domain.QDose.dose;

import com.viewpharm.yakal.domain.Dose;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

@Repository
@RequiredArgsConstructor
public class DoseDslRepositoryImpl implements IDoseDslRepository {

    private final JPAQueryFactory jpaQueryFactory;
}
