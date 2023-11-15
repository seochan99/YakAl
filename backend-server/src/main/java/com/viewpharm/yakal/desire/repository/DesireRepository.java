package com.viewpharm.yakal.desire.repository;

import com.viewpharm.yakal.desire.domain.Desire;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DesireRepository extends JpaRepository<Desire, Long> {

    Page<Desire> findAll(Pageable pageable);
}
