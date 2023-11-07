package com.viewpharm.yakal.prescription.repository;

import com.viewpharm.yakal.prescription.domain.Dose;
import com.viewpharm.yakal.prescription.domain.DoseName;
import com.viewpharm.yakal.base.type.EDosingTime;
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

    @Query(value = "SELECT * FROM (SELECT  date, COUNT(*) as count FROM doses WHERE user_id = :userId AND date >= :startDate AND date <= :endDate GROUP BY risk_id, date) overlap where count > 1 order by count desc ", nativeQuery = true)
    List<overlap> findOverlap(@Param("userId") Long userId, @Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);

    @Query(value = "SELECT * FROM (SELECT risk_id as ATCCode,GROUP_CONCAT(DISTINCT dosename_id) AS KDCodes ,COUNT(*) as count FROM doses" +
            " WHERE user_id = :userId AND date = :date AND exist_morning = true GROUP BY risk_id, date, is_morning_taken) overlap" +
            " WHERE count > 1", nativeQuery = true)
    List<overlapDetail> findOverlapDetailMorning(@Param("userId") Long userId, @Param("date") LocalDate date);

    @Query(value = "SELECT * FROM (SELECT risk_id as ATCCode ,GROUP_CONCAT(DISTINCT dosename_id) AS KDCodes ,COUNT(*) as count FROM doses" +
            " WHERE user_id = :userId AND date = :date AND exist_afternoon = true GROUP BY risk_id, date, is_afternoon_taken) overlap" +
            " WHERE count > 1", nativeQuery = true)
    List<overlapDetail> findOverlapDetailAfternoon(@Param("userId") Long userId, @Param("date") LocalDate date);

    @Query(value = "SELECT * FROM (SELECT risk_id as ATCCode ,GROUP_CONCAT(DISTINCT dosename_id) AS KDCodes ,COUNT(*) as count FROM doses" +
            " WHERE user_id = :userId AND date = :date AND exist_evening = true GROUP BY risk_id, date, is_evening_taken) overlap" +
            " WHERE count > 1", nativeQuery = true)
    List<overlapDetail> findOverlapDetailEvening(@Param("userId") Long userId, @Param("date") LocalDate date);

    @Query(value = "SELECT * FROM (SELECT risk_id as ATCCode ,GROUP_CONCAT(DISTINCT dosename_id) AS KDCodes ,COUNT(*) as count FROM doses" +
            " WHERE user_id = :userId AND date = :date AND exist_default = true GROUP BY risk_id, date, is_default_taken) overlap" +
            " WHERE count > 1", nativeQuery = true)
    List<overlapDetail> findOverlapDetailDefault(@Param("userId") Long userId, @Param("date") LocalDate date);

    Boolean existsByUserIdAndKDCodeAndDateAndExistMorningTrue(Long userId, DoseName KDCode, LocalDate date);

    Boolean existsByUserIdAndKDCodeAndDateAndExistAfternoonTrue(Long userId, DoseName KDCode, LocalDate date);

    Boolean existsByUserIdAndKDCodeAndDateAndExistEveningTrue(Long userId, DoseName KDCode, LocalDate date);

    Boolean existsByUserIdAndKDCodeAndDateAndExistDefaultTrue(Long userId, DoseName KDCode, LocalDate date);


    @Query("select sum(case when d.existMorning = true then 1 else 0 end + " +
            "case when d.existAfternoon = true then 1 else 0 end + " +
            "case when d.existEvening = true then 1 else 0 end + " +
            "case when d.existDefault = true then 1 else 0 end) as total, sum(case when d.isMorningTaken = true then 1 else 0 end + " +
            "case when d.isAfternoonTaken = true then 1 else 0 end + " +
            "case when d.isEveningTaken = true then 1 else 0 end + " +
            "case when d.isDefaultTaken = true then 1 else 0 end) as take, d.date as date " +
            "from Dose d where d.user.id = :userId and d.date between :start and :end group by d.date")
    List<oneDaySummary> countTotalAndTakenByUserIdInPeriod(@Param("userId")Long userId, @Param("start")LocalDate start, @Param("end")LocalDate end);

    @Modifying(clearAutomatically = true)
    @Query("update Dose d set d.pillCnt = :pillCnt, d.isHalf = :isHalf where d.id = :doseId")
    Integer updateCountById(Long doseId, Long pillCnt, Boolean isHalf);

    @Override
    @Modifying(clearAutomatically = true, flushAutomatically = true)
    void deleteAllByIdInBatch(Iterable<Long> longs);

    @Query(value = "SELECT dn.dose_name as name, r.score as score, p.prescribed_date as prescribedDate FROM doses d " +
            "JOIN risks r ON d.risk_id = r.id JOIN prescriptions p ON d.prescription_id = p.id JOIN dosenames dn ON d.dosename_id = dn.id " +
            "where d.user_id = :userId and p.is_allow = true and p.prescribed_date >= :lastDate " +
            "group by name, score, prescribedDate order by prescribedDate", nativeQuery = true)
    List<prescribed> findAllByUserIdAndLastDate(@Param("userId") Long userId, @Param("lastDate") LocalDate lastDate);


    @Query(value = "select distinctrow d.created_at as PrescribedAt, dn.dose_name as Name from doses d join dosenames dn on d.dosename_id = dn.id " +
            "where d.user_id = :userId and d.is_deleted = false order by d.created_at desc limit 5", nativeQuery = true)
    List<doseInfo> findTop5ByUserAndIsDeletedOrderByCreatedDesc(@Param("userId") Long userId);

    @Query(value = "SELECT distinctrow dn.dose_name as Name, d.created_at as PrescribedAt From doses d join dosenames dn on d.dosename_id  = dn.id " +
            "join risks r on d.risk_id = r.id AND (r.properties = 1 OR r.properties = 2) " +
            "where d.user_id = :userId AND d.is_deleted = false",
            countQuery = "SELECT count(distinctrow dn.dose_name, d.created_at) From doses d join dosenames dn on d.dosename_id  = dn.id " +
                    "join risks r on d.risk_id = r.id AND r.properties = 1 " +
                    "where d.user_id = :userId AND d.is_deleted = false",
            nativeQuery = true)
    Page<doseInfo> findByUserAndIsDeletedAndIsBeersOrderByCreatedDesc(@Param("userId") Long userId, Pageable pageable);

    @Query(value = "SELECT distinctrow dn.dose_name as Name, d.created_at as PrescribedAt, r.score as Score From doses d " +
            "join dosenames dn on d.dosename_id  = dn.id " +
            "join risks r on d.risk_id = r.id AND (r.properties = 0 OR r.properties = 2) " +
            "where d.user_id = :userId AND d.is_deleted = false",
            countQuery = "SELECT count(distinctrow dn.dose_name, d.created_at, r.score) From doses d " +
                    "join dosenames dn on d.dosename_id  = dn.id " +
                    "join risks r on d.risk_id = r.id AND r.properties = 0 " +
                    "where d.user_id = :userId AND d.is_deleted = false",
            nativeQuery = true)
    Page<anticholinergicDoseInfo> findByUserAndIsDeletedAndIsAnticholinergicOrderByCreatedDesc(@Param("userId") Long userId, Pageable pageable);

    @Query(value = "SELECT distinctrow dn.dose_name as Name, d.created_at as PrescribedAt From doses d join dosenames dn on d.dosename_id  = dn.id " +
            "where d.user_id = :userId AND d.is_deleted = false",
            countQuery = "SELECT count(distinctrow dn.dose_name, d.created_at) From doses d join dosenames dn on d.dosename_id  = dn.id " +
                    "where d.user_id = :userId AND d.is_deleted = false",
            nativeQuery = true)
    Page<doseInfo> findByUserAndIsDeletedOrderByCreatedDesc(@Param("userId") Long userId, Pageable pageable);

    @Query(value = "select dose_name as name,dosename_id as kdCode, count(*) as cnt " +
            "from doses join dosenames d on doses.dosename_id = d.id " +
            "where doses.date >= :start and doses.date <= :end " +
            "group by dosename_id order by cnt desc limit 10"
            ,nativeQuery = true)
    List<mostDoseInfo> findDosesTop10(LocalDate start,LocalDate end);

    interface doseAntiInfo {
        String getDoseName();

        LocalDate getDate();

        int getRisk();
    }


    interface overlap {
        LocalDate getDate();

        Long getCount();
    }

    interface overlapDetail extends overlap {
        String getATCCode();

//        EDosingTime getTime();

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

    interface anticholinergicDoseInfo {
        String getName();

        Timestamp getPrescribedAt();

        Integer getScore();
    }

    interface mostDoseInfo{
        String getName();
        String getkdCode();
        Long getCnt();
    }
}
