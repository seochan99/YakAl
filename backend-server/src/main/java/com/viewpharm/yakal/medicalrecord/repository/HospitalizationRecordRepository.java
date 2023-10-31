package com.viewpharm.yakal.medicalrecord.repository;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.medicalrecord.domain.HospitalizationRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HospitalizationRecordRepository extends JpaRepository<HospitalizationRecord, Long> {
    List<HospitalizationRecord> findAllByUserOrderByDateDesc(User user);
}
