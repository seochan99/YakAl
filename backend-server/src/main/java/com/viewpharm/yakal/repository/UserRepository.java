package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.type.EDosingTime;
import com.viewpharm.yakal.type.ERole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    @Modifying(clearAutomatically = true)
    @Query("update User u set u.name = :name where u.id = :userId")
    Integer updateNameById(Long userId, String name);

    Boolean existsByIdAndRoleAndRefreshToken(Long userId, ERole role, String refreshToken);

    //select user_id from doses where date='2023-07-24' and time ='DINNER' group by user_id;

    interface UserLoginForm {
        Long getId();

        ERole getUserRole();
    }


    Optional<ERole> getRoleById(Long userId);
}
