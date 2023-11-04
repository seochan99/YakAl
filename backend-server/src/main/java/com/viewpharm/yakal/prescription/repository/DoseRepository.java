package com.viewpharm.yakal.prescription.repository;

import com.viewpharm.yakal.prescription.domain.Dose;
import com.viewpharm.yakal.prescription.domain.DoseName;
import com.viewpharm.yakal.base.type.EDosingTime;
import com.viewpharm.yakal.user.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
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

    @Query(value = "SELECT * FROM (SELECT risks_id as ATCCode, time ,GROUP_CONCAT(DISTINCT dosename_id) AS KDCodes ,COUNT(*) as count FROM doses" +
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

    Boolean existsByUserIdAndKDCodeAndDateAndTime(Long userId, DoseName KDCode, LocalDate date, EDosingTime time);

    @Override
    @Modifying(clearAutomatically = true, flushAutomatically = true)
    void deleteAllByIdInBatch(Iterable<Long> longs);

    @Query(value = "SELECT dn.dose_name as name, r.score as score, p.prescribed_date as prescribedDate FROM doses d " +
            "JOIN risks r ON d.risks_id = r.id JOIN prescriptions p ON d.prescription_id = p.id JOIN dosenames dn ON d.dosename_id = dn.id " +
            "where d.user_id = :userId and p.is_allow = true and p.prescribed_date >= :lastDate " +
            "group by name, score, prescribedDate order by prescribedDate", nativeQuery = true)
    List<prescribed> findAllByUserIdAndLastDate(@Param("userId") Long userId, @Param("lastDate") LocalDate lastDate);


    @Query(value = "select distinctrow d.created_at as PrescribedAt, dn.dose_name as Name from doses d join dosenames dn on d.dosename_id = dn.id " +
            "where d.user_id = :userId and d.is_deleted = :isDeleted order by d.created_at desc limit 5", nativeQuery = true)
    List<doseInfo> findTop5ByUserAndIsDeletedOrderByDateDesc(@Param("userId") Long userId, @Param("isDeleted") Boolean isDeleted);

    @Query(value = "SELECT dn.dose_name as Name, d.date as PrescribedAt From doses d " +
            "inner join dosenames dn on d.dosename_id  = dn.id " +
            "inner join risks r on d.risks_id = r.id AND (r.properties = 1 OR r.properties = 2) " +
            "where d.user_id = :userId AND d.is_deleted = :isDeleted", nativeQuery = true)
    Page<doseInfo> findByUserAndIsDeletedAndIsBeersOrderByDateDesc(@Param("userId") Long userId, @Param("isDeleted") Boolean isDeleted, Pageable pageable);

    @Query(value = "SELECT dn.dose_name as Name, d.date as PrescribedAt From doses d " +
            "inner join dosenames dn on d.dosename_id  = dn.id " +
            "inner join risks r on d.risks_id = r.id AND (r.properties = 0 OR r.properties = 2) " +
            "where d.user_id = :userId AND d.is_deleted = :isDeleted", nativeQuery = true)
    Page<doseInfo> findByUserAndIsDeletedAndIsAnticholinergicOrderByDateDesc(@Param("userId") Long userId, @Param("isDeleted") Boolean isDeleted, Pageable pageable);

    Page<Dose> findByUserAndIsDeletedOrderByDateDesc(User user, Boolean isDeleted, Pageable pageable);

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
        String getName();

        int getScore();

        LocalDate getPrescribedDate();
    }

    interface doseInfo {
        String getName();
        Timestamp getPrescribedAt();
    }
}
