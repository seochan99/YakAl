package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Board;
import com.viewpharm.yakal.domain.Comment;
import com.viewpharm.yakal.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CommentRepository extends JpaRepository<Comment, Long> {
    //Page<Comment> findByBoardAndIsDeleted(Board board, Boolean isDeleted);
    //Long countByUser(User user);
    //Long countByUserAndIsDeleted(User user, Boolean isDeleted);

}
