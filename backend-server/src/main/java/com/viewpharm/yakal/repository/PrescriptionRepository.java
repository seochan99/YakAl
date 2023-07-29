package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Prescription;
import com.viewpharm.yakal.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PrescriptionRepository extends JpaRepository<Prescription, Long> {
}
