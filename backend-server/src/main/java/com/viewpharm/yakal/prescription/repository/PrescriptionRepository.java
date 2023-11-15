package com.viewpharm.yakal.prescription.repository;

import com.viewpharm.yakal.prescription.domain.Prescription;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PrescriptionRepository extends JpaRepository<Prescription, Long> {

    List<Prescription> findByUserId(Long userId);
    Optional<Prescription> findTop1ByUserId(Long userId);

}
