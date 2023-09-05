package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Dose;
import com.viewpharm.yakal.type.EDosingTime;
import com.viewpharm.yakal.type.EPeriod;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface DoseRepository extends JpaRepository<Dose, Long> {

    @Query("select d from Dose d join fetch d.ATCCode where d.user.id = :userId and d.date = :date ")
    List<Dose> findByUserIdAndDate(@Param("userId") Long userId, @Param("date") LocalDate date);

    @Query("select d from Dose d where d.user.id = :userId and d.date = :date and d.time =:time")
    List<Dose> findByUserIdAndDateAndTime(@Param("userId") Long userId, @Param("date") LocalDate date, @Param("time") EDosingTime time);

    @Query(value = "SELECT * FROM (SELECT  date, COUNT(*) as count FROM doses WHERE user_id = :userId AND date >= :startDate AND date <= :endDate GROUP BY risks_id, date, time) overlap where count > 1 order by count desc ", nativeQuery = true)
    List<overlap> findOverlap(@Param("userId") Long userId, @Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);

    @Query(value = "SELECT * FROM (SELECT risks_id as ATCCode, time ,GROUP_CONCAT(DISTINCT kd_code) AS KDCodes ,COUNT(*) as count FROM doses" +
            " WHERE user_id = :userId AND date = :date GROUP BY risks_id, date, time) overlap" +
            " WHERE count > 1", nativeQuery = true)
    List<overlapDetail> findOverlapDetail(@Param("userId") Long userId, @Param("date") LocalDate date);


    @Query("select sum(1) as total, sum(case when d.isTaken = true then 1 else 0 end) as take from Dose d where d.user.id = :userId and d.date = :date")
    oneDaySummary countTotalAndTakenByUserIdAndDate(Long userId, LocalDate date);

    @Query("select sum(1) as total, sum(case when d.isTaken = true then 1 else 0 end) as take, d.date as date from Dose d where d.user.id = :userId and d.date between :start and :end group by d.date")
    List<oneDaySummary> countTotalAndTakenByUserIdInPeriod(Long userId, LocalDate start, LocalDate end);

    @Modifying(clearAutomatically = true)
    @Query("update Dose d set d.pillCnt = :pillCnt, d.isHalf = :isHalf where d.id = :doseId")
    Integer updateCountById(Long doseId, Long pillCnt, Boolean isHalf);

    Boolean existsByUserIdAndKDCodeAndDateAndTime(Long userId, String KDCode, LocalDate date, EDosingTime time);

    @Override
    @Modifying(clearAutomatically = true, flushAutomatically = true)
    void deleteAllByIdInBatch(Iterable<Long> longs);

    @Query(value = "SELECT  d.kd_code as KDCode, r.score as score, p.prescribed_date as date FROM doses d " +
            "JOIN  risks r ON d.risks_id = r.id " +
            "JOIN prescriptions p ON d.prescription_id = p.id " +
            "where d.user_id = :userId and p.is_allow = true and p.prescribed_date >= :lastDate " +
            "group by kd_code , score, p.prescribed_date " +
            "order by p.prescribed_date", nativeQuery = true)
    List<prescribed> findDistinctByKDCodeAndPrescription(@Param("userId") Long userId, @Param("lastDate") LocalDate lastDate, Pageable pageable);

    interface oneDaySummary {

        Long getTotal();

        Long getTake();

        LocalDate getDate();
    }

    interface overlap {
        LocalDate getDate();

        Long getCount();
    }

    interface overlapDetail extends overlap {
        String getATCCode();

        EDosingTime getTime();

        List<String> getKDCodes();
    }

    interface prescribed {
        String getKDCode();

        int getScore();

        LocalDate getDate();
    }

}
