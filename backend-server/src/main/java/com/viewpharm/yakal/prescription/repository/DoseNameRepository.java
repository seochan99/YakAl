package com.viewpharm.yakal.prescription.repository;


import com.viewpharm.yakal.prescription.domain.DoseName;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface DoseNameRepository extends JpaRepository<DoseName, String> {
    @Query(value = "SELECT * FROM dosenames WHERE dose_name = :dosename LIMIT 1", nativeQuery = true)
    Optional<DoseName> findByDoseName(String dosename);

    @Query(value = "SELECT * FROM dosenames WHERE MATCH(dose_name) AGAINST(:dosename in boolean mode) LIMIT 1",nativeQuery = true)
    Optional<DoseName> findByDoseNameSimilar(String dosename);
}
