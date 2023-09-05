package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Board;
import com.viewpharm.yakal.domain.Like;
import com.viewpharm.yakal.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface LikeRepository extends JpaRepository<Like, Long> {
    List<Like> findByUserId(Long userId);

    List<Like> findByBoardId(Long boardId);

    Optional<Like> findByUserAndBoard(User user, Board board);
}
