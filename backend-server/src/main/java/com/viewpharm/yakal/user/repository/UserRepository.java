package com.viewpharm.yakal.user.repository;

import com.viewpharm.yakal.base.type.ERole;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.base.type.EJob;
import com.viewpharm.yakal.base.type.ELoginProvider;
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
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findBySocialIdAndLoginProvider(String socialId, ELoginProvider loginProvider);

    Optional<User> findByIdAndIsLoginAndRefreshTokenIsNotNull(Long userId, Boolean isLogin);

    @Modifying(clearAutomatically = true)
    @Query("update User u set u.isDetail = :isDetail where u.id = :userId")
    Integer updateIsDetailById(Long userId, Boolean isDetail);

    @Modifying(clearAutomatically = true)
    @Query("update User u set u.notiIsAllowed = :notiIsAllowed where u.id = :userId")
    Integer updateNotiIsAllowedById(Long userId, Boolean notiIsAllowed);

    @Modifying(clearAutomatically = true)
    @Query("update User u set u.name = :name where u.id = :userId")
    Integer updateNameById(Long userId, String name);

    @Modifying(clearAutomatically = true)
    @Query("update User u set u.name = :name, u.isDetail = :isDetail where u.id = :userId")
    Integer updateNameAndIsDetailById(Long userId, String name, Boolean isDetail);

//    @Modifying(clearAutomatically = true)
//    @Query("update User u set u.isCertified = :isCertified, u.job = :job  where u.id = :userId")
//    Integer updateIsCertified(Long userId, Boolean isCertified, EJob job);

    @Query(value = "SELECT user_id as UserId, user_name as Username, COUNT(dose_id) as Count" +
            " FROM (SELECT u.id as user_id, u.name as user_name, d.id as dose_id" +
            " from users u" +
            " inner join doses d on u.id = d.user_id" +
            " where d.date = :date and u.breakfast_time = :localTime) as q" +
            " GROUP BY user_name, user_id", nativeQuery = true)
    List<UserNotificationForm> findByDateAndBreakfastTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);

    @Query(value = "SELECT user_id as UserId, user_name as Username, COUNT(dose_id) as Count" +
            " FROM (SELECT u.id as user_id, u.name as user_name, d.id as dose_id" +
            " from users u" +
            " inner join doses d on u.id = d.user_id" +
            " where d.date = :date and u.lunch_time = :localTime) as q" +
            " GROUP BY user_name, user_id", nativeQuery = true)
    List<UserNotificationForm> findByDateAndLunchTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);

    @Query(value = "SELECT user_id as UserId, user_name as Username, COUNT(dose_id) as Count" +
            " FROM (SELECT u.id as user_id, u.name as user_name, d.id as dose_id" +
            " from users u" +
            " inner join doses d on u.id = d.user_id" +
            " where d.date = :date and u.dinner_time = :localTime) as q" +
            " GROUP BY user_name, user_id", nativeQuery = true)
    List<UserNotificationForm> findByDateAndDinnerTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);

    @Query(value = "SELECT user_id as UserId, user_name as Username, COUNT(dose_id) as Count" +
            " FROM (SELECT u.id as user_id, u.name as user_name, d.id as dose_id" +
            " from users u" +
            " inner join doses d on u.id = d.user_id" +
            " where d.date = :date and u.breakfast_time = :localTime) as q" +
            " GROUP BY user_name, user_id", nativeQuery = true)
    List<UserNotificationForm> findByDateAndTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);

//    @Query("select u from User u where u.id=:id and (u.job=:doctor or u.job = :pharmacist)")
//    Optional<User> findByIdAndJobOrJob(@Param("id") Long userId, @Param("doctor") EJob doctor, @Param("pharmacist") EJob pharmacist);

    @Query("select u from User u where u.id = :id and u.role = :role")
    Optional<User> findByIdAndRole(@Param("id") Long userId, @Param("role") ERole role);

    @Query("select m.name from User u join MedicalEstablishment m on u.medicalEstablishment.id = m.id where u.id = :id")
    Optional<String> getEstablishmentNameByIdAndRole(@Param("id") Long userId);

    Optional<User> findById(Long userId);

    List<User> findByNameAndBirthday(String name, LocalDate birthday);

//    @Query("select u from User u where u.realName=:realName and (u.job=:doctor or u.job = :pharmacist)")
//    List<User> findByRealNameAndJobOrJob(String realName, EJob doctor, EJob pharmacist);

    @Query("select u from User u join fetch u.myGuardian g where g.patient=:user")
    List<User> searchGuardianForUser(@Param("user") User user);

    @Query("select u from User u join fetch u.myGuardian g where g.patient=:user order by g.createdDate desc limit 1")
    Optional<User> searchResentGuardianForUser(@Param("user") User user);

    @Query("select u from User u join fetch u.medicalAppointmentForPatient ma where ma.patient=:user")
    List<User> searchExpertForUser(@Param("user") User user);

    interface UserNotificationForm {
        Long getUserId();

        String getUsername();

        Integer getCount();
    }
}
