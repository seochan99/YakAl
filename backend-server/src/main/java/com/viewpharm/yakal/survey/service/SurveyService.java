package com.viewpharm.yakal.survey.service;

import com.viewpharm.yakal.base.utils.SurveyParseUtil;
import com.viewpharm.yakal.notablefeature.domain.Fall;
import com.viewpharm.yakal.notablefeature.repository.FallRepository;
import com.viewpharm.yakal.survey.domain.Answer;
import com.viewpharm.yakal.survey.domain.Survey;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.survey.dto.request.AnswerRequestDto;
import com.viewpharm.yakal.survey.dto.response.AnswerDetailDto;
import com.viewpharm.yakal.survey.dto.response.AnswerListDto;
import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import com.viewpharm.yakal.survey.repository.AnswerRepository;
import com.viewpharm.yakal.survey.repository.SurveyRepository;
import com.viewpharm.yakal.user.repository.UserRepository;
import com.viewpharm.yakal.base.type.EJob;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.Collections;
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
    private final FallRepository fallRepository;

    private final SurveyParseUtil surveyParseUtil;

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

//        //요청 유저 유효성 확인
//        if (!(Objects.equals(answer.getUser().getId(), user.getId()) || user.getJob() == EJob.DOCTOR || user.getJob() == EJob.PHARMACIST))
//            throw new CommonException(ErrorCode.NOT_EQUAL);


        return AnswerDetailDto.builder()
                .title(answer.getSurvey().getTitle())
                .content(answer.getContent())
                .result(answer.getScore())
                .build();
    }

    public Map<String, Object> getAllSeniorAnswerListForExpert(Long expertId, Long patientId) {
//        userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST)
//                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
//
//        final User patient = userRepository.findById(patientId)
//                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
//
//        final List<AnswerRepository.answerInfo> answers = answerRepository.findSurveyByUserIdAndIsSenior(patient.getId(), true);
//
//        final Map<String, Object> answerMap =  answers.stream()
//                .collect(HashMap::new, (m1, m2) -> m1.put(m2.getMiniTitle(), m2.getContent()), HashMap::putAll);
//
//        for (Map.Entry<String, Object> entry : answerMap.entrySet()) {
//            switch (entry.getKey()) {
//                case "mna" -> {
//                    if (entry.getValue() == null) {
//                        entry.setValue(Collections.emptyList());
//                    } else {
//                        entry.setValue(surveyParseUtil.parseStringToIntArrayOrNull((String) entry.getValue()));
//                    }
//                }
//                case "adl", "delirium" -> {
//                    if (entry.getValue() == null) {
//                        entry.setValue(Collections.emptyList());
//                    } else {
//                        entry.setValue(surveyParseUtil.parseStringToBooleanArrayOrNull((String) entry.getValue()));
//                    }
//                }
//                case "audiovisual" -> {
//                    final Map<String, Boolean> audiovisualAnswerMap = new HashMap<>(2);
//
//                    if (entry.getValue() == null) {
//                        audiovisualAnswerMap.put("useGlasses", null);
//                        audiovisualAnswerMap.put("useHearingAid", null);
//                    } else {
//                        final List<Boolean> audiovisualAnswerList = surveyParseUtil.parseStringToBooleanArrayOrNull((String) entry.getValue());
//                        audiovisualAnswerMap.put("useGlasses", audiovisualAnswerList.get(0));
//                        audiovisualAnswerMap.put("useHearingAid", audiovisualAnswerList.get(1));
//                    }
//
//                    entry.setValue(audiovisualAnswerMap);
//                }
//            }
//        }
//
//        final List<Fall> falls = fallRepository.findAllByUserOrderByDateDesc(patient);
//
//        final List<LocalDate> fallDateList = falls.stream()
//                .map(f -> f.getDate().toLocalDate())
//                .toList();
//
//        answerMap.put("fall", fallDateList);
//
//        return answerMap;

        return null;
    }

    public Map<String, Object> getAllNotSeniorAnswerListForExpert(Long expertId, Long patientId) {
//        userRepository.findByIdAndJobOrJob(expertId, EJob.DOCTOR, EJob.PHARMACIST)
//                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));
//
//        final User patient = userRepository.findById(patientId)
//                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
//
//        final List<AnswerRepository.answerInfo> answers = answerRepository.findSurveyByUserIdAndIsSenior(patient.getId(), false);
//
//        final Map<String, Object> answerMap =  answers.stream()
//                .collect(HashMap::new, (m1, m2) -> m1.put(m2.getMiniTitle(), m2.getContent()), HashMap::putAll);
//
//        for (Map.Entry<String, Object> entry : answerMap.entrySet()) {
//            switch (entry.getKey()) {
//                case "arms", "phqNine", "drinking", "dementia", "insomnia", "smoking" -> {
//                    if (entry.getValue() == null) {
//                        entry.setValue(Collections.emptyList());
//                    } else {
//                        entry.setValue(surveyParseUtil.parseStringToIntArrayOrNull((String) entry.getValue()));
//                    }
//                }
//                case "gds", "frailty", "osa" -> {
//                    if (entry.getValue() == null) {
//                        entry.setValue(Collections.emptyList());
//                    } else {
//                        entry.setValue(surveyParseUtil.parseStringToBooleanArrayOrNull((String) entry.getValue()));
//                    }
//                }
//            }
//        }
//
//        return answerMap;

        return null;
    }
}