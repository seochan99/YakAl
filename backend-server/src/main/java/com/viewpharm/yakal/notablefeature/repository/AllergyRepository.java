package com.viewpharm.yakal.notablefeature.repository;

import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.notablefeature.domain.Allergy;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AllergyRepository extends JpaRepository<Allergy, Long> {
    Optional<Allergy> findByName(String notableFeature);

    List<Allergy> findAllByUserOrderByIdDesc(User user);
}
