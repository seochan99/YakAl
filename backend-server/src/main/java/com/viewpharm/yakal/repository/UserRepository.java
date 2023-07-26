package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.type.ERole;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Boolean existsByIdAndRoleAndRefreshToken(Long userId, ERole role, String refreshToken);

   Optional<ERole> getRoleById(Long userId);
}
