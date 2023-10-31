package com.viewpharm.yakal.medicalestablishment.repository;

import com.viewpharm.yakal.medicalestablishment.domain.ExpertCertification;
import com.viewpharm.yakal.medicalestablishment.domain.MedicalEstablishment;
import com.viewpharm.yakal.user.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ExpertCertificationRepository extends JpaRepository<ExpertCertification, Long> {

    Optional<ExpertCertification> findByUserAndMedicalEstablishmentAndIsProcessed(User user, MedicalEstablishment medicalEstablishment, Boolean isProcessed);

    Optional<ExpertCertification> findByUserAndIsProcessed(User user, Boolean isProcessed);
}
