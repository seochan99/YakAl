package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.MobileUser;
import com.viewpharm.yakal.type.EDosingTime;
import com.viewpharm.yakal.type.ERole;
import com.viewpharm.yakal.type.ELoginProvider;
import com.viewpharm.yakal.type.ESex;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
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
    List<UserNotificationFrom> findByDateAndTime(@Param("date") LocalDate localDate, @Param("dosingTime") EDosingTime dosingTime);

    interface UserNotificationFrom {
        MobileUser getUser();

        int getCount();
    }
}
