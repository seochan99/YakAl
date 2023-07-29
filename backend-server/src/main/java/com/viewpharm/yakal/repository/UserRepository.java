package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.type.ERole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    @Modifying(clearAutomatically = true)
    @Query("update User u set u.name = :name where u.id = :userId")
    Integer updateNameById(Long userId, String name);

    Boolean existsByIdAndRoleAndRefreshToken(Long userId, ERole role, String refreshToken);

    Optional<ERole> getRoleById(Long userId);
}
