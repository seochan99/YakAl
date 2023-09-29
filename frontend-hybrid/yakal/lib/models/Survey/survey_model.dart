import 'question_model.dart';

class SurveyModel {
  final String title;
  final String comment;
  final String time;
  final String iconPath;
  final List<QuestionModel> questions;
  bool isCompleted;
  int totalScore;
  String resultComment;
  final String resultDescription;

  SurveyModel({
    required this.title,
    required this.comment,
    required this.questions,
    required this.time,
    required this.iconPath,
    required this.isCompleted,
    required this.totalScore,
    required this.resultComment,
    required this.resultDescription,
  });

  int get getTotalScore => totalScore;

  set setTotalScore(int score) {
    totalScore = score;
  }

  void setComment(int score) {
    switch (title) {
      case '복약 순응도 테스트':
        resultComment = '$score/48점 입니다.';
        break;
      case '우울증 선별검사':
        if (score >= 0 && score <= 4) {
          resultComment = '우울증상이 없습니다';
        } else if (score >= 5 && score <= 9) {
          resultComment = '가벼울 우울증상이 있습니다';
        } else if (score >= 10 && score <= 19) {
          resultComment = '중간정도의 우울증이 의심됩니다';
        } else if (score >= 20 && score <= 27) {
          resultComment = '심한 우울증이 의심됩니다';
        } else {
          resultComment = 'Unknown score range';
        }
        break;
      default:
        resultComment = 'Default comment for unknown survey type';
    }
  }

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
    // 12개의 질문만들기
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
    resultDescription:
        "복약 순응도 점수가 낮은 상황에서는 의사의 처방 및\n약사의 복약지도가 환자의 건강상태를 개선시키는 데 어려움이 있습니다.\n\n해당되는 이용자에게는 적절한 복약 알림과 \n복약 현황 파악을 통해 복약 순응도를 높일 수 있습니다.",
  ),
];
