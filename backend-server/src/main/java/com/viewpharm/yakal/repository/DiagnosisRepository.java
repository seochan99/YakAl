package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.notablefeatures.domain.MedicalHistory;
import com.viewpharm.yakal.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

//기저 질환 및 알러지으로 변경 예정
@Deprecated
public interface DiagnosisRepository extends JpaRepository<MedicalHistory, Long> {

    List<MedicalHistory> findAllByUser(User user);
}
