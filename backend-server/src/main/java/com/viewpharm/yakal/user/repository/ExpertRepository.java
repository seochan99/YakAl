package com.viewpharm.yakal.user.repository;

import com.viewpharm.yakal.user.domain.Expert;
import com.viewpharm.yakal.user.domain.User;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ExpertRepository  extends JpaRepository<Expert, Long> {
    Optional<Expert> findByUser(User user);
    List<Expert> findExpertByIsProcessed(Boolean isProcessed,Pageable pageable);
}
