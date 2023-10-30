package com.viewpharm.yakal.notablefeatures.repository;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.notablefeatures.domain.Allergy;
import com.viewpharm.yakal.notablefeatures.domain.DietarySupplement;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AllergyRepository extends JpaRepository<Allergy, Long> {
    Optional<Allergy> findByName(String notableFeature);

    List<Allergy> findAllByUserOrderByIdDesc(User user);
}
