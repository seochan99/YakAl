package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Board;
import com.viewpharm.yakal.domain.Comment;
import com.viewpharm.yakal.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface CommentRepository extends JpaRepository<Comment, Long> {
    Page<Comment> findByBoardAndIsDeleted(Board board, Boolean isDeleted, Pageable pageable);

    Page<Comment> findByUserAndIsDeleted(User user, Boolean isDeleted, Pageable pageable);

    Optional<Comment> findByIdAndUserAndBoardAndIsDeleted(Long id, User user, Board board, Boolean isDeleted);

    @Query("select c from Comment c left join fetch c.parent where c.board.id = :id and c.isDeleted = false" +
            " order by c.parent.id NULLS FIRST, c.createDate desc")
    Page<Comment> findByBoardIdAndIsDeleted(@Param("id") Long boardId, Pageable pageable);


}
