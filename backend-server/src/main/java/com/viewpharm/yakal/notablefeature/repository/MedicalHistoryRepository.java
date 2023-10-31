package com.viewpharm.yakal.notablefeature.repository;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.notablefeature.domain.MedicalHistory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MedicalHistoryRepository extends JpaRepository<MedicalHistory, Long> {
    List<MedicalHistory> findAllByUserOrderByIdDesc(User user);
}
