package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.MobileUser;
import com.viewpharm.yakal.type.EDosingTime;
import com.viewpharm.yakal.type.ELoginProvider;
import com.viewpharm.yakal.type.ESex;
import org.springframework.beans.factory.annotation.Value;
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

    @Query(value = "SELECT user_id as UserId, user_name as Username, COUNT(dose_id) as Count" +
            " FROM (SELECT m.user_id as user_id, name as user_name, d.id as dose_id" +
            " from mobile_users m" +
            " inner join users u on m.user_id = u.id" +
            " inner join doses d on m.user_id = d.user_id" +
            " where d.date = :date and m.breakfast_time = :localTime) as q" +
            " GROUP BY user_name, user_id", nativeQuery = true)
    List<MobileUserNotificationForm> findByDateAndBreakfastTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);

    @Query(value = "SELECT user_id as UserId, user_name as Username, COUNT(dose_id) as Count" +
            " FROM (SELECT m.user_id as user_id, name as user_name, d.id as dose_id" +
            " from mobile_users m" +
            " inner join users u on m.user_id = u.id" +
            " inner join doses d on m.user_id = d.user_id" +
            " where d.date = :date and m.lunch_time = :localTime) as q" +
            " GROUP BY user_name, user_id", nativeQuery = true)
    List<MobileUserNotificationForm> findByDateAndLunchTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);

    @Query(value = "SELECT user_id as UserId, user_name as Username, COUNT(dose_id) as Count" +
            " FROM (SELECT m.user_id as user_id, name as user_name, d.id as dose_id" +
            " from mobile_users m" +
            " inner join users u on m.user_id = u.id" +
            " inner join doses d on m.user_id = d.user_id" +
            " where d.date = :date and m.dinner_time = :localTime) as q" +
            " GROUP BY user_name, user_id", nativeQuery = true)
    List<MobileUserNotificationForm> findByDateAndDinnerTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);

    @Query(value = "SELECT user_id as UserId, user_name as Username, COUNT(dose_id) as Count" +
            " FROM (SELECT m.user_id as user_id, name as user_name, d.id as dose_id" +
            " from mobile_users m" +
            " inner join users u on m.user_id = u.id" +
            " inner join doses d on m.user_id = d.user_id" +
            " where d.date = :date and m.dinner_time = :localTime) as q" +
            " GROUP BY user_name, user_id", nativeQuery = true)
    List<MobileUserNotificationForm> findByDateAndTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);


    interface MobileUserNotificationForm {
        Long getUserId();
        String getUsername();
        Integer getCount();
    }

}
