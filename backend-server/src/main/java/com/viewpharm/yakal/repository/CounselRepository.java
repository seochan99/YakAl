package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Counsel;
import com.viewpharm.yakal.domain.User;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CounselRepository extends JpaRepository<Counsel, Long> {
    List<Counsel> findByPatientIdAndIsDeleted(Long patientId, Boolean isDeleted);

    List<Counsel> findByExpertIdAndIsDeleted(Long expertId, Boolean isDeleted, Pageable pageable);

    Optional<Counsel> findByExpertAndPatient(User expert, User patient);

    Optional<Counsel> findByIdAndIsDeleted(Long counselId, Boolean isDeleted);
}
