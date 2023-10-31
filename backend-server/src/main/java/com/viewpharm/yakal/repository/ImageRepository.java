package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.*;
import com.viewpharm.yakal.user.domain.Expert;
import com.viewpharm.yakal.user.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ImageRepository extends JpaRepository<Image, Long> {
    Optional<Image> findByUser(User user);
    Optional<Image> findByMedical(Medical medical);
    Optional<Image> findByUuidName(String uuidName);
    Optional<Image> findByRegistration(Registration registration);
    List<Image> findByExpert(Expert expert);
}
