package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Counsel;
import com.viewpharm.yakal.domain.User;
import org.checkerframework.checker.units.qual.C;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CounselRepository extends JpaRepository<Counsel, Long> {
    Optional<Counsel> findByPatientIdAndIsDeleted(Long patientId, Boolean isDeleted);

    Page<Counsel> findByExpertIdAndIsDeleted(Long expertId, Boolean isDeleted, Pageable pageable);

    Optional<Counsel> findByExpertAndPatient(User expert, User patient);

    Optional<Counsel> findByExpertAndPatientAndIsDeleted(User expert, User patient, Boolean isDeleted);

    Optional<Counsel> findByIdAndIsDeleted(Long counselId, Boolean isDeleted);

    @Query("select c from Counsel c join fetch c.patient where c.expert=:expert")
    Page<Counsel> findListByExpert(@Param("expert") User expert, Pageable pageable);

    @Query("select c from Counsel c join fetch c.patient where c.expert=:expert and c.patient.name like %:name%")
    Page<Counsel> findListByExpertAndPatientName(@Param("expert") User expert, @Param("name") String name, Pageable pageable);
}
