package com.viewpharm.yakal.notablefeature.repository;

import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.notablefeature.domain.UnderlyingCondition;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UnderlyingConditionRepository extends JpaRepository<UnderlyingCondition, Long> {


    List<UnderlyingCondition> findAllByUserOrderByIdDesc(User user);

    Optional<UnderlyingCondition> findByName(String name);
}
