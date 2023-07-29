package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.MobileUser;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.type.EDosingTime;
import com.viewpharm.yakal.type.ELoginProvider;
import com.viewpharm.yakal.type.ESex;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface MobileUserRepository extends JpaRepository<MobileUser, Long> {

    Optional<MobileUser> findBySocialIdAndLoginProvider(String socialId, ELoginProvider loginProvider);

    Optional<MobileUser> findByIdAndIsLoginAndRefreshTokenIsNotNull(Long userId, Boolean isLogin);

    @Modifying(clearAutomatically = true)
    @Query("update MobileUser u set u.isDetail = :isDetail where u.id = :userId")
    Integer updateIsDetailById(Long userId, Boolean isDetail);

    @Modifying(clearAutomatically = true)
    @Query("update MobileUser u set u.isAllowedNotification = :isAllowedNotification where u.id = :userId")
    Integer updateIsAllowedNotificationById(Long userId, Boolean isAllowedNotification);

    @Modifying(clearAutomatically = true)
    @Query("update MobileUser u set u.name = :name, u.birthday = :birthday, u.isDetail = :isDetail, u.sex = :sex where u.id = :userId")
    Integer updateNameAndBirthdayAndIsDetailAndSexById(Long userId, String name, LocalDate birthday, Boolean isDetail, ESex sex);

    // select user_id from doses where date='2023-07-24' and time ='DINNER' group by user_id;
    @Query("SELECT u, count(*) from Dose d join fetch User u where d.date = :date and d.time = :dosingTime group by u")
    List<MobileUserNotificationForm> findByDateAndTime(@Param("date") LocalDate localDate, @Param("dosingTime") EDosingTime dosingTime);

    @Query("SELECT m, count(*) from Dose d join fetch MobileUser m where d.date = :date and d.time = :dosingTime group by m")
    List<MobileUserNotificationForm> findByDateAndDosingTime(@Param("date") LocalDate localDate, @Param("dosingTime") EDosingTime dosingTime);

    @Query("SELECT m, count(*) from Dose d join fetch MobileUser m where d.date = :date and m.breakfastTime = :localTime group by m")
    List<MobileUserNotificationForm> findByDateAndBreakfastTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);

    @Query("SELECT m, count(*) from Dose d join fetch MobileUser m where d.date = :date and m.lunchTime = :localTime group by m")
    List<MobileUserNotificationForm> findByDateAndLunchTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);

    @Query("SELECT m, count(*) from Dose d join fetch MobileUser m where d.date = :date and m.dinnerTime = :localTime group by m")
    List<MobileUserNotificationForm> findByDateAndDinnerTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);

    interface MobileUserNotificationForm {
        MobileUser getMobileUser();

        int getCount();
    }

}
