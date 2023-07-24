package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Dose;
import com.viewpharm.yakal.type.EDosingTime;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import static org.hibernate.FetchMode.SELECT;

@Repository
public interface DoseRepository extends JpaRepository<Dose, Long> {
    List<Dose> findByUserIdAndDate(@Param("userId") Long userId, @Param("date") LocalDate date);
    List<Dose> findByUserIdAndDateAndTime(@Param("userId") Long userId, @Param("date") LocalDate date, @Param("time")EDosingTime time);
    Optional<Dose> findByUserIdAndDateAndTimeAndPillName(@Param("userId") Long userId, @Param("date") LocalDate date, @Param("time")EDosingTime time,@Param("pill_name")String pillName);
}
