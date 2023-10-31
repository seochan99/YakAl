import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Survey/survey_model.dart';
import 'package:yakal/utilities/api/api.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class SurveyDetailBokyakController extends GetxController {
  final SurveyModel surveyModel;

  SurveyDetailBokyakController({required this.surveyModel}) {
    selectedOptions = List.filled(surveyModel.questions.length, null);
  }

  Future<void> setDoneSurvey() async {
    var dio = await authDioWithContext();

    try {
      var response = await dio.get("/surveys/answer");

      if (response.statusCode == 200) {
        List dataList = response.data['data']['datalist'];

        for (var data in dataList) {
          if (data['title'] == surveyModel.title) {
            surveyModel.isCompleted = true;
            update(); // GetX의 update 메서드를 호출하여 UI에 변경 사항을 반영합니다.
            return;
          }
        }
        surveyModel.isCompleted = false;
      } else {
        surveyModel.isCompleted = false;
      }
    } catch (e) {
      throw Exception('Failed to load PillTodoParents');
    }
  }

  late List<String?> selectedOptions;

  void onOptionSelected(int questionIndex, int optionIndex) {
    selectedOptions[questionIndex] =
        surveyModel.questions[questionIndex].options[optionIndex];
    update();
  }

  int calculateTotalScore() {
    int totalScore = 0;
    if (selectedOptions.length != surveyModel.questions.length) {
      throw ArgumentError(
          'selectedOptions and questions must have the same length');
    }

    for (int i = 0; i < selectedOptions.length; i++) {
      String? selectedOption = selectedOptions[i];

      if (selectedOption != null &&
          surveyModel.questions[i].options.contains(selectedOption)) {
        int optionIndex =
            surveyModel.questions[i].options.indexOf(selectedOption);
        totalScore += surveyModel.questions[i].scores[optionIndex];
      }
    }
    return totalScore;
  }

// 완료 버튼 활성화 여부
  bool isCompletionEnabled() {
    for (var question in surveyModel.questions) {
      if (selectedOptions[surveyModel.questions.indexOf(question)] == null) {
        return false;
      }
    }
    return true;
  }

// 선택 항목의 점수를 리스트로 반환
  List allScoreList() {
    List arms = [];
    for (int i = 0; i < selectedOptions.length; i++) {
      String? selectedOption = selectedOptions[i];

      if (selectedOption != null &&
          surveyModel.questions[i].options.contains(selectedOption)) {
        int optionIndex =
            surveyModel.questions[i].options.indexOf(selectedOption);
        arms.add(surveyModel.questions[i].scores[optionIndex]);
      }
    }
    return arms;
  }

// 완료버튼을 눌렀을때
  Future handleButtonPress() async {
    int totalScore = calculateTotalScore();
    // 서버로 arms 리스트 보내기
    List results = allScoreList();

    var dio = await authDioWithContext();

    try {
      // 설문 결과 등록
      var response = await dio.post("/surveys/${surveyModel.id}/answer",
          data: {"content": jsonEncode(results), "score": totalScore});

      // 200이면
      if (response.statusCode == 200) {
        // 총점
        surveyModel.totalScore = totalScore;
        // 완료 여부 업데이트
        surveyModel.isCompleted = true;

        // result Comment 셋팅
        surveyModel.setComment(surveyModel.totalScore);

        // 결과 페이지 이동
        Get.toNamed('/survey/result',
            arguments: {'survey': surveyModel, 'results': results});

        // 데이터 반환
        return response.data['data'];
      }
    } catch (e) {
      Get.snackbar(
        '설문 결과',
        '설문 결과 등록에 실패했어요.',
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        duration: const Duration(seconds: 1, microseconds: 500),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorStyles.gray1,
        colorText: Colors.black,
      );
      throw Exception('Failed to load PillTodoParents');
    }
  }
}
