package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Dose;
import com.viewpharm.yakal.domain.MobileUser;
import com.viewpharm.yakal.domain.Prescription;
import com.viewpharm.yakal.type.EDosingTime;
import org.hibernate.annotations.SQLDelete;
import org.springframework.cglib.core.Local;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Repository
public interface DoseRepository extends JpaRepository<Dose, Long> {

    @Query("select d from Dose d where d.mobileUser.id = :userId and d.date = :date")
    List<Dose> findByUserIdAndDate(Long userId, LocalDate date);

    @Query("select sum(1) as total, sum(case when d.isTaken = true then 1 else 0 end) as portion from Dose d where d.mobileUser.id = :userId and d.date = :date")
    TotalAndPortion countTotalAndTakenByUserIdAndDate(Long userId, LocalDate date);

    @Query("select sum(1) as total, sum(case when d.isTaken = true then 1 else 0 end) as portion from Dose d where d.mobileUser.id = :userId and d.date between :start and :end group by d.date order by d.date")
    List<TotalAndPortion> countTotalAndTakenByUserIdInPeriod(Long userId, LocalDate start, LocalDate end);

    @Query("""
        select distinct d1.date as date from Dose d1 where (d1.mobileUser.id = :userId) and (d1.date between :start and :end)
        and exists (select 1 from Dose d2 where (d1.mobileUser.id = d2.mobileUser.id) and (d1.ATCCode = d2.ATCCode) and (function('datediff', d1.date, d2.date) between 1 and :period))
        """)
    Set<LocalDate> hasOverlappedIngredientByUserIdInPeriod(Long userId, LocalDate start, LocalDate end, Long period);

    @Modifying(clearAutomatically = true)
    @Query("update Dose d set d.pillCnt = :pillCnt, d.isHalf = :isHalf where d.id = :doseId")
    Integer updateCountById(Long doseId, Long pillCnt, Boolean isHalf);

    @Modifying(clearAutomatically = true)
    @Query("update Dose d set d.isTaken = :isTaken where d.mobileUser.id = :userId and d.date = :date and d.time = :time")
    Integer updateIsTakenByUserIdAndDateAndTime(Long userId, LocalDate date, EDosingTime time, Boolean isTaken);

    @Query("update Dose d set d.isTaken = :isTaken where d.mobileUser.id = :userId and d.id = :doseId")
    Integer updateIsTakenByDoseId(Long userId, Long doseId, Boolean isTaken);

    Boolean existsByMobileUserIdAndKDCodeAndATCCodeAndDateAndTime(Long userId, String KDCode, String ATCCode, LocalDate date, EDosingTime time);

    @Override
    @Modifying(clearAutomatically = true, flushAutomatically = true)
    void deleteAllByIdInBatch(Iterable<Long> longs);

    interface TotalAndPortion {

        Long getTotal();
        Long getPortion();
    }
}
