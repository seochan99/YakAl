package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Answer;
import com.viewpharm.yakal.domain.Diagnosis;
import com.viewpharm.yakal.domain.Surbey;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.request.AnswerRequestDto;
import com.viewpharm.yakal.dto.request.DiagnosisRequestDto;
import com.viewpharm.yakal.dto.response.AnswerAllDto;
import com.viewpharm.yakal.dto.response.AnswerDetailDto;
import com.viewpharm.yakal.dto.response.AnswerListDto;
import com.viewpharm.yakal.dto.response.DiagnosisListDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.AnswerRepository;
import com.viewpharm.yakal.repository.DiagnosisRepository;
import com.viewpharm.yakal.repository.SurbeyRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.EJob;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class SurbeyService {
    private final UserRepository userRepository;
    private final SurbeyRepository surbeyRepository;
    private final AnswerRepository answerRepository;


    public Boolean createAnswer(Long userId, Long surbeyId, AnswerRequestDto requestDto) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Surbey surbey = surbeyRepository.findById(surbeyId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_SURBEY));


        //입력값 유효성 확인
        if ((requestDto.getContent().length() == 0) || (requestDto.getScore() <= 0)) {
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);
        }

        //예전에 한 설문조사가 있다면 삭제
        answerRepository.findBySurbeyAndUser(surbey, user)
                .ifPresent(a -> answerRepository.delete(a));

        answerRepository.save(Answer.builder()
                .content(requestDto.getContent())
                .score(requestDto.getScore())
                .surbey(surbey)
                .user(user)
                .build());

        return Boolean.TRUE;
    }

    public AnswerDetailDto readAnswer(Long userId, Long answerId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Answer answer = answerRepository.findById(answerId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_ANSWER));

        //요청 유저 유효성 확인
        if (!(answer.getUser().getId() == user.getId() || user.getJob() == EJob.DOCTOR || user.getJob() == EJob.PHARMACIST))
            throw new CommonException(ErrorCode.NOT_EQUAL);

        return AnswerDetailDto.builder()
                .title(answer.getSurbey().getTitle())
                .content(answer.getContent())
                .result(answer.getScore())
                .build();
    }


    // 수정 없음
    public Boolean deleteAnswer(Long userId, Long answerId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Answer answer = answerRepository.findById(answerId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_ANSWER));

        //요청 유저 유효성 확인
        if (!(answer.getUser().getId() == user.getId() || user.getJob() == EJob.DOCTOR || user.getJob() == EJob.PHARMACIST))
            throw new CommonException(ErrorCode.NOT_EQUAL);

        answerRepository.delete(answer);

        return Boolean.TRUE;
    }

    //자기 설문조사 리스트
    public AnswerAllDto getAllAnswerList(Long userId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<Answer> answers = answerRepository.findAllByUser(user);

        List<AnswerListDto> listDtos = answers.stream()
                .map(a -> new AnswerListDto(a.getSurbey().getTitle(), a.getScore()))
                .collect(Collectors.toList());

        return AnswerAllDto.builder()
                .datalist(listDtos)
                .percent(listDtos.size() * 100 / 14)
                .build();
    }

    //전문가가 환자 설문조사 리스트
    public AnswerAllDto getAllAnswerListForExpert(Long expertId, Long patientId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //유저 확인
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));


        List<Answer> answers = answerRepository.findAllByUser(patient);

        List<AnswerListDto> listDtos = answers.stream()
                .map(a -> new AnswerListDto(a.getSurbey().getTitle(), a.getScore()))
                .collect(Collectors.toList());

        return AnswerAllDto.builder()
                .datalist(listDtos)
                .percent(listDtos.size() * 100 / 14)
                .build();
    }


}
