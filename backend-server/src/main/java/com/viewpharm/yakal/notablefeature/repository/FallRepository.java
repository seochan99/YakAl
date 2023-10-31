package com.viewpharm.yakal.notablefeature.repository;

import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.notablefeature.domain.Fall;
import org.springframework.data.jpa.repository.JpaRepository;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

public interface FallRepository extends JpaRepository<Fall, Long> {
    Optional<Fall> findByDate(Date date);

    List<Fall> findAllByUserOrderByDateDesc(User user);
}
