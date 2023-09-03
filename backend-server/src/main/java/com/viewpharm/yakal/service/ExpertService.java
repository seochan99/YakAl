package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Expert;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.ExpertRepository;
import com.viewpharm.yakal.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class ExpertService {
    private final ExpertRepository expertRepository;
    private final UserRepository userRepository;
    public Boolean createExpert(final Long userId){
        final User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        // Expert 가 이미 존재하는 경우
        if(user.getExpert() != null)
            return Boolean.FALSE;

        Expert expert = Expert.builder().user(user).build();
        user.setExpert(expert);
        expertRepository.save(expert);

        return Boolean.TRUE;
    }
}
