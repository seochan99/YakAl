package com.viewpharm.yakal.repository;


import com.viewpharm.yakal.domain.DoseName;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface DoesNameRepository extends JpaRepository<DoseName, String> {
    Optional<DoseName> findByDoseName(String dosename);
}
