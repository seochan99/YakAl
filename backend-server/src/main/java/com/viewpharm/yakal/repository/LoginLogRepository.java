package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.LoginLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

@Repository
public interface LoginLogRepository extends JpaRepository<LoginLog, Long> {

    //1일 단위
    Long countLoginLogByLoginTime(LocalDate date);

    //특정 기간 일 단위로 묶기
    @Query(value = "SELECT login_time AS LoginTime, COUNT(login_time) AS Count FROM login_logs " +
            "WHERE login_time >= :startDate AND login_time <= :endDate " +
            "GROUP BY login_time ORDER BY LoginTime desc", nativeQuery = true)
    List<oneDayInformation> getLoginTimeAndCountForDay(@Param("startDate") LocalDate start, @Param("endDate") LocalDate end);

    @Query(value = "SELECT DATE_FORMAT(login_time,'%Y-%m') AS LoginTime, COUNT(login_time) AS Count FROM login_logs " +
            "WHERE DATE_FORMAT(login_time,'%Y-%m') >= :startDate AND DATE_FORMAT(login_time,'%Y-%m') <= :endDate GROUP BY LoginTime", nativeQuery = true)
    List<oneMonthInformation> getLoginTimeAndCountForMonth(@Param("startDate") LocalDate start, @Param("endDate") LocalDate end);

    interface oneDayInformation {
        LocalDate getLoginTime();

        Long getCount();
    }

    interface oneMonthInformation {
        String getLoginTime();

        Long getCount();
    }


}
