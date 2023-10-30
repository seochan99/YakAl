package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.notablefeatures.domain.DietarySupplement;
import com.viewpharm.yakal.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
//비타민으로 변경예정
@Deprecated
public interface HealthFoodRepository extends JpaRepository<DietarySupplement,Long> {
    List<DietarySupplement> findAllByUser(User user);
    Optional<DietarySupplement> findByName(String name);
}
