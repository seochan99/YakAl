package com.viewpharm.yakal.medicalestablishment.repository;

import com.viewpharm.yakal.base.type.EMedical;
import com.viewpharm.yakal.medicalappointment.domain.MedicalAppointment;
import com.viewpharm.yakal.medicalestablishment.domain.MedicalEstablishment;
import com.viewpharm.yakal.user.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.Optional;

public interface MedicalEstablishmentRepository extends JpaRepository<MedicalEstablishment, Long> {

    Optional<MedicalEstablishment> findByEstablishmentNumberAndIsRegister(String establishmentNumber, Boolean isRegister);

    Optional<MedicalEstablishment> findByIdAndIsRegister(Long id, Boolean isRegister);

    @Query("select m from MedicalEstablishment m where m.type = :eType and m.name like %:searchWord% and m.isRegister = true")
    Page<MedicalEstablishment> findListBySearchWord(@Param("eType") EMedical type,
                                                    @Param("searchWord") String searchWord,
                                                    Pageable pageable);

    @Query("select m from MedicalEstablishment m where m.type = :eType and m.isRegister = true")
    Page<MedicalEstablishment> findList(@Param("eType") EMedical type, Pageable pageable);


    @Query(value = "SELECT distinctrow me.id as ID, me.name as NAME, me.`type` as MedicalType, me.chief_name as CHIEFNAME, me.chief_tel as TEL, me.created_at as DATE " +
            "           From medical_establishments me " +
            "           WHERE me.is_register = false",
            countQuery = "SELECT COUNT(distinctrow me.id, me.name, me.`type`, me.chief_name, me.chief_tel, me.created_at) " +
                    "           From medical_establishments me " +
                    "           WHERE me.is_register = false", nativeQuery = true)
    Page<MedicalEstablishmentInfo> findMedicalEstablishmentInfo(Pageable pageable);

    @Query(value = "SELECT distinctrow me.id as ID, me.name as NAME, me.`type` as MedicalType, me.chief_name as CHIEFNAME, me.chief_tel as TEL, me.created_at as DATE " +
            "           From medical_establishments me " +
            "           WHERE me.is_register = false and em.name = :name",
            countQuery = "SELECT COUNT(distinctrow me.id, me.name, me.`type`, me.chief_name, me.chief_tel, me.created_at) " +
                    "           From medical_establishments me " +
                    "           WHERE me.is_register = false and em.name = :name", nativeQuery = true)
    Page<MedicalEstablishmentInfo> findMedicalEstablishmentInfoByName(@Param("name") String name, Pageable pageable);

    interface MedicalEstablishmentInfo {
        Long getId();

        String getName();

        EMedical getMedicalType();

        String getChiefName();

        String getTel();

        LocalDate getDate();

    }
}
