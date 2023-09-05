package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.HealthFood;
import com.viewpharm.yakal.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface HealthFoodRepository extends JpaRepository<HealthFood,Long> {
    List<HealthFood> findAllByUser(User user);
    Optional<HealthFood> findByName(String name);
}