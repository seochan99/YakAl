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

import java.util.Optional;

public interface MedicalEstablishmentRepository extends JpaRepository<MedicalEstablishment, Long> {

    Optional<MedicalEstablishment> findByEstablishmentNumberAndIsRegister(String establishmentNumber, Boolean isRegister);

    Optional<MedicalEstablishment> findByIdAndIsRegister(Long id, Boolean isRegister);

    @Query("select m from MedicalEstablishment m where m.type = :type and m.name like %:searchWord% and m.isRegister = true")
    Page<MedicalEstablishment> findListBySearchWord(@Param("type") EMedical type,
                                                  @Param("searchWord") String searchWord,
                                                  Pageable pageable);
}
