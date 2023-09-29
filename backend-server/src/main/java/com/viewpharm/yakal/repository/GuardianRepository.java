package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Guardian;
import com.viewpharm.yakal.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface GuardianRepository extends JpaRepository<Guardian, Long> {

    Optional<Guardian> findFirstByPatientOrderByCreatedDateDesc(@Param("patient") User patient);

    Optional<Guardian> findFirstByGuardianOrderByCreatedDateDesc(@Param("guardian") User guardian);

    Optional<Guardian> findByPatientAndGuardian(User patient, User guardian);
}
