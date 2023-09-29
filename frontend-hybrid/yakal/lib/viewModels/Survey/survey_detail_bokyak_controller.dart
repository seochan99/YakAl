import 'package:get/get.dart';
import 'package:yakal/models/Survey/question_model.dart';
import 'package:yakal/models/Survey/survey_result_model.dart';

class SurveyDetailBokyakController extends GetxController {
  // 12개의 질문에 대한 선택된 옵션을 저장하는 리스트
  List<String?> selectedOptions = List.filled(12, null);

  RxList<QuestionModel> questions = <QuestionModel>[
    QuestionModel(
      question: "얼마나 자주 약 복용하는 것을 잊어버리십니까?",
      options: ['전혀없음', '가끔', '대부분', '항상'],
      scores: [1, 2, 3, 4],
    ),
    // Add other questions similarly
  ].obs;

  void onOptionSelected(int questionIndex, int optionIndex) {
    selectedOptions[questionIndex] =
        questions[questionIndex].options[optionIndex];
    isCompletionEnabled();
    update();
  }

  int calculateTotalScore() {
    int totalScore = 0;
    for (int i = 0; i < selectedOptions.length; i++) {
      int optionIndex = questions[i].options.indexOf(selectedOptions[i]!);
      if (optionIndex >= 0) {
        totalScore += questions[i].scores[optionIndex];
      }
    }
    return totalScore;
  }

  // 완료 버튼 활성화 여부
  bool isCompletionEnabled() {
    for (var question in questions) {
      if (selectedOptions[questions.indexOf(question)] == null) {
        return false;
      }
    }
    return true;
  }

  // 결과 페이지에서 보여줄 코멘트
  String calculateResultComment(int totalScore) {
    return "Your result comment based on the total score: $totalScore";
  }

  // 결과 페이지로 이동
  void handleButtonPress() {
    int totalScore = calculateTotalScore();
    String resultComment = calculateResultComment(totalScore);
    SurveyResultModel surveyResult = SurveyResultModel(
      totalScore: totalScore,
      comment: resultComment,
    );

    Get.toNamed('/survey/result', arguments: {'surveyResult': surveyResult});
  }
}
