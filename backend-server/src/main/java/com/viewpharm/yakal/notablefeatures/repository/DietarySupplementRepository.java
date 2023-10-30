package com.viewpharm.yakal.notablefeatures.repository;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.notablefeatures.domain.DietarySupplement;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface DietarySupplementRepository extends JpaRepository<DietarySupplement, Long> {
    Optional<DietarySupplement> findByName(String notableFeature);

    List<DietarySupplement> findAllByUserOrderByIdDesc(User user);
}
