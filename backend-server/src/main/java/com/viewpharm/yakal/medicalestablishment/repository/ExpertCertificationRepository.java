package com.viewpharm.yakal.medicalestablishment.repository;

import com.viewpharm.yakal.medicalestablishment.domain.ExpertCertification;
import com.viewpharm.yakal.medicalestablishment.domain.MedicalEstablishment;
import com.viewpharm.yakal.user.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface ExpertCertificationRepository extends JpaRepository<ExpertCertification, Long> {

    Optional<ExpertCertification> findByUserAndMedicalEstablishmentAndIsProcessed(User user, MedicalEstablishment medicalEstablishment, Boolean isProcessed);

    Optional<ExpertCertification> findByUserAndIsProcessed(User user, Boolean isProcessed);

    @Query(value = "SELECT distinctrow u.name as NAME, u.job as JOB, me.name as MEDICALNAME, u.tel as TEL, ec.created_at as DATE " +
            "From expert_certifications ec " +
            "inner join users u on u.id = ec.user_id " +
            "inner join medical_establishments me on me.id = u.medical_establishment_id",
            countQuery = "SELECT COUNT(distinctrow u.name, u.job, me.name, u.tel, ec.created_at) " +
                    "From expert_certifications ec " +
                    "inner join users u on u.id = ec.user_id " +
                    "inner join medical_establishments me on me.id = u.medical_establishment_id", nativeQuery = true)
    Page<ExpertCertificationInfo> findExpertCertificationInfo(Pageable pageable);

    interface ExpertCertificationInfo {
        String getName();

        String getJob();

        String getMedicalName();

        String getTel();

        String getDate();
    }
}
