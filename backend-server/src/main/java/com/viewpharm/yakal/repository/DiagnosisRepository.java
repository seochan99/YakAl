package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Diagnosis;
import com.viewpharm.yakal.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DiagnosisRepository extends JpaRepository<Diagnosis, Long> {

    List<Diagnosis> findAllByUser(User user);
}
