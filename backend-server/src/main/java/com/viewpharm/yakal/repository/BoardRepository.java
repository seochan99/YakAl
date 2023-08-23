package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Board;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.type.ERegion;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface BoardRepository extends JpaRepository<Board, Long> {
    Optional<Board> findByTitleAndIsDeleted(String title, Boolean isDeleted);

    Optional<Board> findByIdAndIsDeleted(Long boardId, Boolean isDeleted);

    Optional<Board> findByIdNotAndTitleAndIsDeleted(Long boardId, String title, Boolean isDeleted);

    List<Board> findAllByIsDeleted(Boolean status, Pageable pageable);

    List<Board> findListByTitleContainingAndIsDeleted(String title, Boolean isDeleted, Pageable pageable);

    List<Board> findListByUserAndIsDeleted(User user, Boolean isDeleted, Pageable pageable);

    List<Board> findListByRegionAndIsDeleted(ERegion region, Boolean isDeleted, Pageable pageable);

}
