package com.viewpharm.yakal.notablefeature.service;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.notablefeature.domain.Fall;
import com.viewpharm.yakal.notablefeature.dto.request.NotableFeatureDto;
import com.viewpharm.yakal.notablefeature.dto.response.NotableFeatureStringDto;
import com.viewpharm.yakal.notablefeature.repository.FallRepository;
import com.viewpharm.yakal.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class FallService {
    private final FallRepository fallRepository;
    private final UserRepository userRepository;

    public Boolean createFall(Long userId, NotableFeatureDto requestDto) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (requestDto.getNotableFeature().isEmpty())
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);

        fallRepository.save(Fall.builder()
                .date(requestDto.toSqlDate())
                .user(user)
                .build());

        return Boolean.TRUE;
    }

    public List<NotableFeatureStringDto> readFalls(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<Fall> falls = fallRepository.findAllByUserOrderByDateDesc(user);

        return falls.stream()
                .map(fall -> new NotableFeatureStringDto(fall.getId(), fall.getDate().toString()))
                .collect(Collectors.toList());
    }

    public Boolean deleteFall(Long userId, Long healthFoodId){
        Fall allergy = fallRepository.findById(healthFoodId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_NOTABLE_FEATURE));

        if (allergy.getUser().getId() != userId)
            throw new CommonException(ErrorCode.NOT_EQUAL);

        fallRepository.delete(allergy);

        return Boolean.TRUE;
    }
}
