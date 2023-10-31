package com.viewpharm.yakal.medicalrecord.repository;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.medicalrecord.domain.EmergencyRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmergencyRecordRepository extends JpaRepository<EmergencyRecord, Long> {
    List<EmergencyRecord> findAllByUserOrderByDateDesc(User user);
}
