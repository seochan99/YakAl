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
}
