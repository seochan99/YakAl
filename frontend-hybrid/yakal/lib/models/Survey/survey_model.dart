import 'question_model.dart';

class SurveyModel {
  final String title;
  final String comment;
  final String time;
  final String iconPath;
  final List<QuestionModel> questions;
  final bool isCompleted;
  int totalScore;
  String resultComment;

  SurveyModel({
    required this.title,
    required this.comment,
    required this.questions,
    required this.time,
    required this.iconPath,
    required this.isCompleted,
    required this.totalScore,
    required this.resultComment,
  });

  // Getter for totalScore
  int get getTotalScore => totalScore;

  // Setter for totalScore
  set setTotalScore(int score) {
    totalScore = score;
  }

// setter
  set setComment(String comment) {
    resultComment = comment;
  }

  // Getter for resultComment
  String get getResultComment => resultComment;
}

const List<String> questionsBokyak = [
  "얼마나 자주 약 복용하는 것을 잊어버리십니까?",
  "얼마나 자주 약을 복용하지 않겠다고\n결정하십니까?",
  "얼마나 자주 약 받는 것을 잊어버리십니까?",
  "얼마나 자주 약이 다 떨어집니까?",
  "의사에게 가기 전에 얼마나 자주 약 복용하는 것을 건너 뛰십니까?",
  "몸이 나아졌다고 느낄 때 얼마나 자주 약 복용하는 것을 빠뜨리십니까?",
  "몸이 아프다고 느낄 때 얼마나 자주 약 복용을 빠뜨리십니까?",
  "얼마나 자주 본인의 부주의로 약 복용하는 것을 빠뜨리십니까?",
  "얼마나 자주 본인의 필요에 따라 약 용량을 바꾸십니까?\n(원래 복용하셔야 하는 것보다 더 많게 혹은 더 적게 복용하시는 것)",
  "하루 한번이상 약을 복용해야 할 때 얼마나 자주\n약 복용 하는 것을 잊어버리십니까?",
  "얼마나 자주 약값이 비싸서 다시 약 처방 받는 것을 미루십니까?",
  "약이 떨어지기 전에 얼마나 자주 미리 계획하여\n약 처방을 다시 받습니까?",
];

final List<SurveyModel> tests = [
  SurveyModel(
    title: '복약 순응도 테스트',
    comment: '약알 이용자의 복약 습관과 복약 순응도를\n 파악하여 의약품 복용에\n도움을 드리기 위한 설문입니다.',
    iconPath: 'assets/icons/circle_1.svg',
    time: '3',
    isCompleted: false,
    questions: List<QuestionModel>.generate(
      12,
      (index) => QuestionModel(
        question: questionsBokyak[index],
        options: ['전혀없음', '가끔', '대부분', '항상'],
        scores: [1, 2, 3, 4],
      ),
    ),
    totalScore: 0,
    resultComment: '',
  ),
];
