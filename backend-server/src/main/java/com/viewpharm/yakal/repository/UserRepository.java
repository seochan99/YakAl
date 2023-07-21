package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.type.EUserRole;
import com.viewpharm.yakal.type.ELoginProvider;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, String> {
    Optional<User> findBySocialIdAndLoginProvider(String socialId, ELoginProvider loginProvider);

    @Query("SELECT u.id AS id, u.userRole AS userRole FROM User u WHERE u.id = :userId AND u.isLogin = true AND u.refreshToken = :refreshToken")
    Optional<UserLoginForm> findByIdAndRefreshToken(@Param("userId") Long userId, @Param("refreshToken") String refreshToken);

    Optional<User> findByIdAndIsLoginAndRefreshTokenIsNotNull(Long userId, Boolean isLogin);

    interface UserLoginForm {
        Long getId();
        EUserRole getUserRole();
    }
}
