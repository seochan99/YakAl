package com.viewpharm.yakal.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class DoseDslRepositoryImpl implements IDoseDslRepository {

    private final JPAQueryFactory jpaQueryFactory;
}
