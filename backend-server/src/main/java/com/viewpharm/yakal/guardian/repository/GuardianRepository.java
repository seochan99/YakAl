package com.viewpharm.yakal.guardian.repository;

import com.viewpharm.yakal.guardian.domain.Guardian;
import com.viewpharm.yakal.user.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface GuardianRepository extends JpaRepository<Guardian, Long> {

    Optional<Guardian> findFirstByPatientOrderByCreatedDateDesc(@Param("patient") User patient);

    Optional<Guardian> findFirstByGuardianOrderByCreatedDateDesc(@Param("guardian") User guardian);

    Optional<Guardian> findByPatientAndGuardian(User patient, User guardian);
}
