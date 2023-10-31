package com.viewpharm.yakal.medicalappointment.repository;

import com.viewpharm.yakal.medicalappointment.domain.MedicalAppointment;
import com.viewpharm.yakal.user.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface MedicalAppointmentRepository extends JpaRepository<MedicalAppointment, Long> {
    Optional<MedicalAppointment> findByPatientIdAndIsDeleted(Long patientId, Boolean isDeleted);

    Page<MedicalAppointment> findByExpertIdAndIsDeleted(Long expertId, Boolean isDeleted, Pageable pageable);

    Optional<MedicalAppointment> findByExpertAndPatient(User expert, User patient);

    Optional<MedicalAppointment> findByExpertAndPatientAndIsDeleted(User expert, User patient, Boolean isDeleted);

//    @Query("select c from MedicalAppointment c join fetch c.patient where c.expert=:expert")
//    Page<MedicalAppointment> findListByExpert(@Param("expert") User expert, Pageable pageable);
//
//    @Query("select c from MedicalAppointment c join fetch c.patient where c.expert=:expert and c.patient.name like %:name%")
//    Page<MedicalAppointment> findListByExpertAndPatientName(@Param("expert") User expert, @Param("name") String name, Pageable pageable);
}
