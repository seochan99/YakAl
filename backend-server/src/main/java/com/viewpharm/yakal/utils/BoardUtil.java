package com.viewpharm.yakal.utils;

import com.viewpharm.yakal.domain.Board;
import com.viewpharm.yakal.domain.Like;
import com.viewpharm.yakal.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;

@Slf4j
@Configuration
@RequiredArgsConstructor
public class BoardUtil {

    public boolean existLike(User user, Board board) {
        for (Like like : user.getLikes()) {
            if (!like.getBoard().equals(board)) {
                continue;
            }
            return true;
        }
        return false;
    }

}
