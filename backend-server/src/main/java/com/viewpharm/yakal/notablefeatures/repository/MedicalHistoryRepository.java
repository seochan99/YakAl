package com.viewpharm.yakal.notablefeatures.repository;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.notablefeatures.domain.MedicalHistory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MedicalHistoryRepository extends JpaRepository<MedicalHistory, Long> {
    List<MedicalHistory> findAllByUserOrderByIdDesc(User user);
}
