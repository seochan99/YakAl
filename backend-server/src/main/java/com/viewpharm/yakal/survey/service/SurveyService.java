package com.viewpharm.yakal.survey.service;

import com.viewpharm.yakal.survey.domain.Answer;
import com.viewpharm.yakal.survey.domain.Survey;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.survey.dto.request.AnswerRequestDto;
import com.viewpharm.yakal.survey.dto.response.AnswerDetailDto;
import com.viewpharm.yakal.survey.dto.response.AnswerListDto;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.survey.repository.AnswerRepository;
import com.viewpharm.yakal.survey.repository.SurveyRepository;
import com.viewpharm.yakal.user.repository.UserRepository;
import com.viewpharm.yakal.base.type.EJob;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class SurveyService {
    private final UserRepository userRepository;
    private final SurveyRepository surveyRepository;
    private final AnswerRepository answerRepository;


    public Map<String, String> createAnswer(Long userId, Long surveyId, AnswerRequestDto requestDto) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        Survey survey = surveyRepository.findById(surveyId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_SURBEY));


        //입력값 유효성 확인
        if ((requestDto.getContent().isEmpty()) || (requestDto.getScore() <= 0)) {
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);
        }

        //예전에 한 설문조사가 있다면 삭제
        answerRepository.findBySurveyAndUser(survey, user)
                .ifPresent(answerRepository::delete);

        answerRepository.flush();

        answerRepository.save(Answer.builder()
                .content(requestDto.getContent())
                .score(requestDto.getScore())
                .resultComment(requestDto.getResultComment())
                .survey(survey)
                .user(user)
                .build());

        Map<String, String> result = new HashMap<>();
        result.put("resultComment", requestDto.getResultComment());

        return result;
    }

    public Map<String, ?> readAnswers(Long userId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<Answer> answers = answerRepository.findAllByUser(user);

        Map<String, List<AnswerListDto>> result = new HashMap<>();

        result.put("result", answers.stream()
                .map(a -> AnswerListDto.builder()
                        .id(a.getId())
                        .title(a.getSurvey().getTitle())
                        .result(a.getScore())
                        .resultComment(a.getResultComment())
                        .build())
                .collect(Collectors.toList()));

        return result;
    }

    public Boolean deleteAnswer(Long userId, Long surveyId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Survey survey = surveyRepository.findById(surveyId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_SURBEY));

        Answer answer = answerRepository.findBySurveyAndUser(survey, user)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_ANSWER));

        answerRepository.delete(answer);

        return Boolean.TRUE;
    }

    public AnswerDetailDto readAnswer(Long userId, Long answerId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Answer answer = answerRepository.findById(answerId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_ANSWER));

        //요청 유저 유효성 확인
        if (!(Objects.equals(answer.getUser().getId(), user.getId()) || user.getJob() == EJob.DOCTOR || user.getJob() == EJob.PHARMACIST))
            throw new CommonException(ErrorCode.NOT_EQUAL);


        return AnswerDetailDto.builder()
                .title(answer.getSurvey().getTitle())
                .content(answer.getContent())
                .result(answer.getScore())
                .build();
    }

    //전문가가 환자 노인병 관련 설문조사 리스트
    public Map<String, ?> getAllSeniorAnswerListForExpert(Long expertId, Long patientId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //유저 확인
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<AnswerRepository.answerInfo> answers = answerRepository.findSurveyForSeniorByUser(patient.getId());

        return answers.stream()
                .collect(Collectors.toMap(a -> a.getMiniTitle(), a -> a.getContent()));
    }

    //전문가가 환자 노인병 외 설문조사 리스트
    public Map<String, ?> getAllNotSeniorAnswerListForExpert(Long expertId, Long patientId) {
        //전문가 확인
        User expert = userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        //유저 확인
        User patient = userRepository.findById(patientId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<AnswerRepository.answerInfo> answers = answerRepository.findSurveyForNotSeniorByUser(patient.getId());

        return answers.stream()
                .collect(Collectors.toMap(a -> a.getMiniTitle(), a -> a.getContent()));
    }


}
