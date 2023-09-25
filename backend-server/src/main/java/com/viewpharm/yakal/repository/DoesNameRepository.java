package com.viewpharm.yakal.repository;


import com.viewpharm.yakal.domain.DoseName;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DoesNameRepository extends JpaRepository<DoseName, String> {
}
