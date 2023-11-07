package com.viewpharm.yakal.survey.repository;

import com.viewpharm.yakal.survey.domain.Survey;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SurveyRepository extends JpaRepository<Survey, Long> {
    @Query(value = "SELECT " +
            "COUNT(*) " +
            "FROM surveys s " +
            "GROUP BY " +
            "CASE " +
            "WHEN s.total_score BETWEEN 0 AND 20 THEN '0~20' " +
            "WHEN s.total_score BETWEEN 21 AND 40 THEN '21~40' " +
            "WHEN s.total_score BETWEEN 41 AND 60 THEN '41~60' " +
            "WHEN s.total_score BETWEEN 61 AND 80 THEN '61~80' " +
            "WHEN s.total_score BETWEEN 81 AND 100 THEN '81~100' " +
            "END",nativeQuery = true)
    List<Long> getSurveyRangesCnt();

}
