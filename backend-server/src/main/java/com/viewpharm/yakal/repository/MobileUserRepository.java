package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.MobileUser;
import com.viewpharm.yakal.type.EDosingTime;
import com.viewpharm.yakal.type.ERole;
import com.viewpharm.yakal.type.ELoginProvider;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface MobileUserRepository extends JpaRepository<MobileUser, Long> {
    Optional<MobileUser> findBySocialIdAndLoginProvider(String socialId, ELoginProvider loginProvider);

    @Query("select count(u.id) > 0 from MobileUser u where u.id = :userId and u.role = :role and u.refreshToken = :refreshToken limit 1")
    Boolean existsByIdAndRoleAndRefreshToken(Long userId, ERole role, String refreshToken);

    Optional<MobileUser> findByIdAndIsLoginAndRefreshTokenIsNotNull(Long userId, Boolean isLogin);

    //select user_id from doses where date='2023-07-24' and time ='DINNER' group by user_id;
    @Query("SELECT u, count(*) from Dose d join fetch User u where d.date = :date and d.time = :dosingTime group by u")
    List<UserNotificationFrom> findByDateAndTime(@Param("date") LocalDate localDate, @Param("dosingTime") EDosingTime dosingTime);

    interface UserNotificationFrom {
        MobileUser getUser();

        int getCount();
    }
}
