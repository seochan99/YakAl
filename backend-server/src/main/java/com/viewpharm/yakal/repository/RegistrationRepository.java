package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Prescription;
import com.viewpharm.yakal.domain.Registration;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RegistrationRepository extends JpaRepository<Registration, Long> {
    List<Registration> getRegistrationByIsPrecessedFalse(Pageable pageable);
}
