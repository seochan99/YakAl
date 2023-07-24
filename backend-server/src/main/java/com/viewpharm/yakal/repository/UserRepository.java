package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.type.EDosingTime;
import com.viewpharm.yakal.type.EUserRole;
import com.viewpharm.yakal.type.ELoginProvider;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findBySocialIdAndLoginProvider(String socialId, ELoginProvider loginProvider);

    @Query("SELECT u.id AS id, u.userRole AS userRole FROM User u WHERE u.id = :userId AND u.isLogin = true AND u.refreshToken = :refreshToken")
    Optional<UserLoginForm> findByIdAndRefreshToken(@Param("userId") Long userId, @Param("refreshToken") String refreshToken);

    Optional<User> findByIdAndIsLoginAndRefreshTokenIsNotNull(Long userId, Boolean isLogin);
    //select user_id from doses where date='2023-07-24' and time ='DINNER' group by user_id;
    @Query("SELECT User.id from Dose d where d.date = :date and d.time = :time group by User.id")
    List<User> findByDateAndTime(@Param("date") LocalDate localDate, @Param("time")EDosingTime dosingTime);


    interface UserLoginForm {
        Long getId();
        EUserRole getUserRole();
    }
}
