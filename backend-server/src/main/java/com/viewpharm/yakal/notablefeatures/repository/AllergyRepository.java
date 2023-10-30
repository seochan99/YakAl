package com.viewpharm.yakal.notablefeatures.repository;

import com.viewpharm.yakal.notablefeatures.domain.Allergy;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AllergyRepository extends JpaRepository<Allergy, Long> {
}
