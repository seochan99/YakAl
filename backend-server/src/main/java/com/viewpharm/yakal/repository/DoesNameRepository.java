package com.viewpharm.yakal.repository;


import com.viewpharm.yakal.domain.DoseName;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface DoesNameRepository extends JpaRepository<DoseName, String> {
    @Query(value = "SELECT * FROM dosenames WHERE dose_name = :dosename LIMIT 1", nativeQuery = true)
    Optional<DoseName> findByDoseName(String dosename);
}
