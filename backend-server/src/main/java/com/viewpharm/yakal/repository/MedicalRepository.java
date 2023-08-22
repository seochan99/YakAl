package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Medical;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MedicalRepository extends JpaRepository<Medical ,Long> {
}
