package com.viewpharm.yakal.prescription.repository;

import com.viewpharm.yakal.base.type.EDosingTime;
import com.viewpharm.yakal.prescription.domain.Dose;
import com.viewpharm.yakal.prescription.domain.DoseName;
import com.viewpharm.yakal.prescription.domain.TakeDose;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.List;

public interface TakeDoseRepository extends JpaRepository<TakeDose, Dose> {
    List<TakeDose> findAllByIdAndDosingTime(Iterable<Dose> doses, EDosingTime dosingTime);

    Boolean existsByDoseAndDosingTime(Dose dose, EDosingTime dosingTime);

    @Query("select count(t) as total, sum(case when t.isTaken = true then 1 else 0 end) as take " +
            "from TakeDose t " +
            "where t.dose.user.id = :userId and t.dose.date = :date")
    oneDaySummary countTotalAndTakenByUserIdAndDate(Long userId, LocalDate date);


    // 여기서 현재 Date를 구하기 어려움
    @Query("select sum(1) as total, sum(case when td.isTaken = true then 1 else 0 end) as take, d.date as date " +
            "from TakeDose td " +
            "join td.dose d " +
            "where d.user.id = :userId and d.date between :start and :end " +
            "group by d.date")
    List<oneDaySummary> countTotalAndTakenByUserIdInPeriod(Long userId, LocalDate start, LocalDate end);


}
