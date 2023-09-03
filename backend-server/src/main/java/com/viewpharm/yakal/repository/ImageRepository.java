package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Expert;
import com.viewpharm.yakal.domain.Image;
import com.viewpharm.yakal.domain.Medical;
import com.viewpharm.yakal.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ImageRepository extends JpaRepository<Image, Long> {
    Optional<Image> findByUser(User user);
    Optional<Image> findByMedical(Medical medical);
    Optional<Image> findByUuidName(String uuidName);
    Optional<Image> findByExpert(Expert expert);
}
