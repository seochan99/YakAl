package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Guardian;
import com.viewpharm.yakal.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface GuardianRepository extends JpaRepository<Guardian, Long> {

    Optional<Guardian> findByPatient(User patient);

    Optional<Guardian> findByGuardian(User guardian);

    Optional<Guardian> findByPatientAndGuardian(User patient, User guardian);

}
