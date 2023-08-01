package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Dose;
import com.viewpharm.yakal.type.EDosingTime;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Set;

@Repository
public interface DoseRepository extends JpaRepository<Dose, Long> {

    @Query("select d from Dose d join fetch d.ATCCode where d.mobileUser.id = :userId and d.date = :date ")
    List<Dose> findByUserIdAndDate(Long userId, LocalDate date);

    @Query("select d from Dose d where d.mobileUser.id = :userId and d.date = :date and d.time =:time")
    List<Dose> findByUserIdAndDateAndTime(Long userId, LocalDate date, EDosingTime time);
    @Query(value = "SELECT * FROM (SELECT DISTINCT date, COUNT(*) as count FROM doses WHERE user_id = :userId AND date >= :startDate AND date <= :endDate GROUP BY risks_id, date) overlap", nativeQuery = true)
    List<overlap> findOverlap(@Param("userId") Long userId, @Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);

    @Query(value = "SELECT * FROM (SELECT risks_id as ATCCode, date,GROUP_CONCAT(DISTINCT kd_code) AS KDCodes ,COUNT(*) as count FROM doses " +
            "WHERE user_id = :userId AND date >= :startDate AND date <= :endDate GROUP BY risks_id, date) overlap " +
            "where date = :specificDate and count > 1", nativeQuery = true)
    List<overlapDetail> findOverlapDetail(@Param("userId") Long userId, @Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate, @Param("specificDate") LocalDate specificDate);


    @Query("select sum(1) as total, sum(case when d.isTaken = true then 1 else 0 end) as take from Dose d where d.mobileUser.id = :userId and d.date = :date")
    oneDaySummary countTotalAndTakenByUserIdAndDate(Long userId, LocalDate date);

    @Query("select sum(1) as total, sum(case when d.isTaken = true then 1 else 0 end) as take, d.date as date from Dose d where d.mobileUser.id = :userId and d.date between :start and :end group by d.date")
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
        LocalDate getDate();
    }

    interface overlap{
        LocalDate getDate();
        Long getCount();
    }

    interface overlapDetail extends overlap{
        String getATCCode();
        List<String> getKDCodes();
    }

}
