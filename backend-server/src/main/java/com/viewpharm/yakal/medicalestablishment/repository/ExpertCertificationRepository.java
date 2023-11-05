package com.viewpharm.yakal.medicalestablishment.repository;

import com.viewpharm.yakal.medicalestablishment.domain.ExpertCertification;
import com.viewpharm.yakal.medicalestablishment.domain.MedicalEstablishment;
import com.viewpharm.yakal.user.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface ExpertCertificationRepository extends JpaRepository<ExpertCertification, Long> {

    Optional<ExpertCertification> findByUserAndMedicalEstablishmentAndIsProcessed(User user, MedicalEstablishment medicalEstablishment, Boolean isProcessed);

    Optional<ExpertCertification> findByUserAndIsProcessed(User user, Boolean isProcessed);

    @Query(value = "SELECT distinctrow u.id as ID, u.name as NAME, u.job as JOB, me.name as MEDICALNAME, u.tel as TEL, ec.created_at as DATE " +
            "From expert_certifications ec " +
            "inner join users u on u.id = ec.user_id " +
            "inner join medical_establishments me on me.id = ec.medical_establishment_id",
            countQuery = "SELECT COUNT(distinctrow u.id, u.name, u.job, me.name, u.tel, ec.created_at) " +
                    "From expert_certifications ec " +
                    "inner join users u on u.id = ec.user_id " +
                    "inner join medical_establishments me on me.id = ec.medical_establishment_id", nativeQuery = true)
    Page<ExpertCertificationInfo> findExpertCertificationInfo(Pageable pageable);

    @Query(value = "SELECT distinctrow u.id as ID, u.name as NAME, u.job as JOB, me.name as MEDICALNAME, u.tel as TEL, ec.created_at as DATE " +
            "From expert_certifications ec " +
            "inner join users u on u.id = ec.user_id " +
            "inner join medical_establishments me on me.id = ec.medical_establishment_id " +
            "where u.name like %:name%",
            countQuery = "SELECT COUNT(distinctrow u.id, u.name, u.job, me.name, u.tel, ec.created_at) " +
                    "From expert_certifications ec " +
                    "inner join users u on u.id = ec.user_id " +
                    "inner join medical_establishments me on me.id = ec.medical_establishment_id " +
                    "where u.name like %:name%", nativeQuery = true)
    Page<ExpertCertificationInfo> findExpertCertificationInfoByName(@Param("name") String name, Pageable pageable);

    interface ExpertCertificationInfo {
        Long getId();

        String getName();

        String getJob();

        String getMedicalName();

        String getTel();

        LocalDate getDate();
    }
}
