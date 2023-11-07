package com.viewpharm.yakal.base.utils;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class SurveyParseUtil {

    public List<Integer> parseStringToIntArrayOrNull(String scores) {
        if (!scores.startsWith("[") || !scores.endsWith("]")) {
            return null;
        }

        final String noBracket = scores.substring(1, scores.length() - 1);
        final String[] scoresStringArray = noBracket.split(",");

        return Arrays.stream(scoresStringArray).map(Integer::parseInt).toList();
    }

    public List<Boolean> parseStringToBooleanArrayOrNull(String answers) {
        if (!answers.startsWith("[") || !answers.endsWith("]")) {
            return null;
        }

        final String noBracket = answers.substring(1, answers.length() - 1);
        final String[] answersStringArray = noBracket.split(",");

        return Arrays.stream(answersStringArray).map(s -> !s.equals("0")).toList();
    }
}
