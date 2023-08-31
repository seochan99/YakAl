package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Expert;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ExpertRepository  extends JpaRepository<Expert, Long> {
}
