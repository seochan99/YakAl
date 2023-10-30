package com.viewpharm.yakal.notablefeatures.repository;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.notablefeatures.domain.MedicalHistory;
import com.viewpharm.yakal.notablefeatures.domain.UnderlyingCondition;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UnderlyingConditionRepository extends JpaRepository<UnderlyingCondition, Long> {


    List<UnderlyingCondition> findAllByUserOrderByIdDesc(User user);

    Optional<UnderlyingCondition> findByName(String name);
}
