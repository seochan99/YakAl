package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Answer;
import com.viewpharm.yakal.domain.Surbey;
import com.viewpharm.yakal.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AnswerRepository extends JpaRepository<Answer, Long> {

    Optional<Answer> findBySurbeyAndUser(Surbey surbey, User user);

    List<Answer> findAllByUser(User user);
}
