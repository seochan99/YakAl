package com.viewpharm.yakal.medicalestablishments.repository;

import com.viewpharm.yakal.medicalestablishments.domain.ExpertCertification;
import com.viewpharm.yakal.medicalestablishments.domain.MedicalEstablishment;
import com.viewpharm.yakal.user.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ExpertCertificationRepository extends JpaRepository<ExpertCertification, Long> {

    Optional<ExpertCertification> findByUserAndMedicalEstablishmentAndIsProcessed(User user, MedicalEstablishment medicalEstablishment, Boolean isProcessed);

    Optional<ExpertCertification> findByUserAndIsProcessed(User user, Boolean isProcessed);
}
