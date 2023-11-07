package com.viewpharm.yakal.survey.repository;

import com.viewpharm.yakal.survey.domain.Answer;
import com.viewpharm.yakal.survey.domain.Survey;
import com.viewpharm.yakal.user.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface AnswerRepository extends JpaRepository<Answer, Long> {

    Optional<Answer> findBySurveyAndUser(Survey survey, User user);

    List<Answer> findAllByUser(User user);

    Long countAnswerByUser(User user);

    @Query("select a.createdDate from Answer a where a.user=:user order by a.createdDate desc limit 1")
    LocalDate findCreateDateByUser(@Param("user") User user);

    @Query(value = "SELECT CASE WHEN a.score BETWEEN 0 AND 20 THEN '0~20' " +
            "WHEN a.score BETWEEN 21 AND 40 THEN '21~40' " +
            "WHEN a.score BETWEEN 41 AND 60 THEN '41~60' " +
            "WHEN a.score BETWEEN 61 AND 80 THEN '61~80' " +
            "WHEN a.score BETWEEN 81 AND 100 THEN '81~100' " +
            "END AS ScoreRange, " +
            "COUNT(*) AS CountScore " +
            "FROM answers a " +
            "GROUP BY ScoreRange", nativeQuery = true)
    List<RangeInfo> getSurveyRangesCnt();

    interface RangeInfo{
        String getScoreRange();

        Long getCountScore();
    }

    @Query(value = "SELECT a.content as Content, s.mini_title as MiniTitle " +
            "from answers a right outer join surveys s on a.surbey_id = s.id and a.user_id = :userId where s.is_senior = :isSenior", nativeQuery = true)
    List<answerInfo> findSurveyByUserIdAndIsSenior(@Param("userId") Long userId, @Param("isSenior") Boolean isSenior);

    interface answerInfo {
        String getContent();

        String getMiniTitle();

    }
}
