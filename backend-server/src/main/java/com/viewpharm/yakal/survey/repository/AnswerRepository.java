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

    @Query(value = "SELECT  a.content as Content, s.mini_title as MiniTitle from answers a " +
            "inner join surveys s on a.surbey_id = s.id AND s.is_senior = true " +
            "where a.user_id = :user", nativeQuery = true)
    List<answerInfo> findSurveyForSeniorByUser(@Param("user") Long userId);

    @Query(value = "SELECT  a.content as Content, s.mini_title as MiniTitle from answers a " +
            "inner join surveys s on a.surbey_id = s.id AND s.is_senior = false " +
            "where a.user_id = :user", nativeQuery = true)
    List<answerInfo> findSurveyForNotSeniorByUser(@Param("user") Long userId);

    interface answerInfo {
        String getContent();

        String getMiniTitle();

    }


}
