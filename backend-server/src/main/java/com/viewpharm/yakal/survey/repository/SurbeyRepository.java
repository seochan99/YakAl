package com.viewpharm.yakal.survey.repository;

import com.viewpharm.yakal.survey.domain.Surbey;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SurbeyRepository extends JpaRepository<Surbey, Long> {

}
