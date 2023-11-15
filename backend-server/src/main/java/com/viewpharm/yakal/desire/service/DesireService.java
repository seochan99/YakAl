package com.viewpharm.yakal.desire.service;

import com.viewpharm.yakal.base.dto.PageInfo;
import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import com.viewpharm.yakal.desire.domain.Desire;
import com.viewpharm.yakal.desire.dto.request.DesireRequestDto;
import com.viewpharm.yakal.desire.dto.response.DesireAllDto;
import com.viewpharm.yakal.desire.dto.response.DesireListDto;
import com.viewpharm.yakal.desire.repository.DesireRepository;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class DesireService {
    private final DesireRepository desireRepository;
    private final UserRepository userRepository;

    //C
    public Boolean createDesire(Long userId, DesireRequestDto requestDto) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        desireRepository.save(Desire.builder()
                .content(requestDto.getContent())
                .user(user)
                .build());

        return Boolean.TRUE;
    }

    //R
    public DesireAllDto getDesireList(String ordering, Long pageIndex) {
        Sort.Direction order;

        if (ordering.equals("desc")) {
            order = Sort.Direction.DESC;
        } else {
            order = Sort.Direction.ASC;
        }

        final int PAGE_SIZE = 10;

        Pageable paging = PageRequest.of(pageIndex.intValue(), PAGE_SIZE, Sort.by(order, "createdDate"));

        Page<Desire> desireList = desireRepository.findAll(paging);

        PageInfo pageInfo = PageInfo.builder()
                .page(pageIndex.intValue())
                .size(PAGE_SIZE)
                .totalElements((int) desireList.getTotalElements())
                .totalPages(desireList.getTotalPages())
                .build();

        List<DesireListDto> desireListDtos = desireList.stream()
                .map(d -> DesireListDto.builder()
                        .content(d.getContent())
                        .date(d.getCreatedDate().toString())
                        .build())
                .collect(Collectors.toList());

        return DesireAllDto.builder()
                .datalist(desireListDtos)
                .pageInfo(pageInfo)
                .build();

    }

}
