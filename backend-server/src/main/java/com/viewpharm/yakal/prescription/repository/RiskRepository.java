package com.viewpharm.yakal.prescription.repository;

import com.viewpharm.yakal.prescription.domain.Risk;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RiskRepository extends JpaRepository<Risk, String> {
}
