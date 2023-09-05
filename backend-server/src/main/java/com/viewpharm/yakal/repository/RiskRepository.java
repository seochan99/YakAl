package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Risk;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RiskRepository extends JpaRepository<Risk, String> {
}
