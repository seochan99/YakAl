package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Dose;
import com.viewpharm.yakal.type.EDosingTime;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Set;

@Repository
public interface DoseRepository extends JpaRepository<Dose, Long> {

    @Query("select d from Dose d where d.mobileUser.id = :userId and d.date = :date")
    List<Dose> findByUserIdAndDate(Long userId, LocalDate date);

    @Query("select d from Dose d where d.mobileUser.id = :userId and d.date = :date and d.time =:time")
    List<Dose> findByUserIdAndDateAndTime(Long userId, LocalDate date, EDosingTime time);
    @Query("SELECT d FROM Dose d " +
            "WHERE d.mobileUser.id = :userId " +
            "AND d.ATCCode = :ATCCode " +
            "AND d.date BETWEEN :startDate AND :endDate")
    List<Dose> findByMobileUserIdAndATCCodeAndDateBetween(Long userId,String ATCCode, LocalDate startDate,LocalDate endDate);

    @Query("select sum(1) as total, sum(case when d.isTaken = true then 1 else 0 end) as take from Dose d where d.mobileUser.id = :userId and d.date = :date")
    oneDaySummary countTotalAndTakenByUserIdAndDate(Long userId, LocalDate date);

    @Query("select sum(1) as total, sum(case when d.isTaken = true then 1 else 0 end) as take,any(d.isOverlap) as overlap,d.date as date from Dose d where d.mobileUser.id = :userId and d.date between :start and :end group by d.date")
    List<oneDaySummary> countTotalAndTakenByUserIdInPeriod(Long userId, LocalDate start, LocalDate end);

    @Modifying(clearAutomatically = true)
    @Query("update Dose d set d.pillCnt = :pillCnt, d.isHalf = :isHalf where d.id = :doseId")
    Integer updateCountById(Long doseId, Long pillCnt, Boolean isHalf);

    Boolean existsByMobileUserIdAndKDCodeAndDateAndTime(Long userId, String KDCode, LocalDate date, EDosingTime time);

    @Override
    @Modifying(clearAutomatically = true, flushAutomatically = true)
    void deleteAllByIdInBatch(Iterable<Long> longs);

    interface oneDaySummary {

        Long getTotal();
        Long getTake();
        Boolean getOverlap();
        LocalDate getDate();
    }
}
