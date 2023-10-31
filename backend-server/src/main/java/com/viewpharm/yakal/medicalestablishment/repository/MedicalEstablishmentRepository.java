package com.viewpharm.yakal.medicalestablishment.repository;

import com.viewpharm.yakal.medicalestablishment.domain.MedicalEstablishment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MedicalEstablishmentRepository extends JpaRepository<MedicalEstablishment, Long> {

    Optional<MedicalEstablishment> findByEstablishmentNumberAndIsRegister(String establishmentNumber, Boolean isRegister);

    Optional<MedicalEstablishment> findByIdAndIsRegister(Long id, Boolean isRegister);
}
