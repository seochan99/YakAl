import 'package:get/get.dart';
import 'package:yakal/models/Survey/survey_model.dart';

class SurveyDetailBokyakController extends GetxController {
  final SurveyModel surveyModel;

  SurveyDetailBokyakController({required this.surveyModel}) {
    selectedOptions = List.filled(surveyModel.questions.length, null);
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

  bool isCompletionEnabled() {
    for (var question in surveyModel.questions) {
      if (selectedOptions[surveyModel.questions.indexOf(question)] == null) {
        return false;
      }
    }
    return true;
  }

  String calculateResultComment(int totalScore) {
    return "Your result comment based on the total score: $totalScore";
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

  void handleButtonPress() {
    int totalScore = calculateTotalScore();
    String resultComment = calculateResultComment(totalScore);
    // 서버로 arms 리스트 보내기
    List arms = allScoreList();

    surveyModel.resultComment = resultComment;
    surveyModel.totalScore = totalScore;

    Get.toNamed('/survey/result', arguments: {'survey': surveyModel});
  }
}
