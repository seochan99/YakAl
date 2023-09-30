import 'question_model.dart';
import './question_data.dart';

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
      case '우울증 선별 테스트':
        if (score >= 0 && score <= 4) {
          resultComment = '우울증상이 없습니다';
        } else if (score >= 5 && score <= 9) {
          resultComment = '가벼울 우울증상이 있습니다';
        } else if (score >= 10 && score <= 19) {
          resultComment = '중간정도의 우울증이 의심됩니다';
        } else if (score >= 20 && score <= 27) {
          resultComment = '심한 우울증이 의심됩니다';
        } else {
          resultComment = '우울증상이 없습니다';
        }
        break;
      case '불면증 심각도 테스트':
        if (score >= 0 && score <= 7) {
          resultComment = '정상입니다';
        } else if (score >= 8 && score <= 14) {
          resultComment = '약간의 불면증이 있습니다';
        } else if (score >= 15 && score <= 21) {
          resultComment = '중등도의 불면증이 있습니다';
        } else if (score >= 22) {
          resultComment = '심한 불면증이 있습니다';
        } else {
          resultComment = '정상입니다';
        }
        break;

      default:
        resultComment = '테스트가 정상적으로 진행되지 않았습니다.';
    }
  }

  String get getResultComment => resultComment;
}

final List<SurveyModel> tests = [
  SurveyModel(
    title: '복약 순응도 테스트',
    comment: '약알 이용자의 복약 습관과 복약 순응도를 파악하여 의약품 복용에 도움을 드리기 위한 설문입니다.',
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
        "복약 순응도 점수가 낮은 상황에서는 의사의 처방 및 약사의 복약지도가 환자의 건강상태를 개선시키는 데 어려움이 있습니다. 해당되는 이용자에게는 적절한 복약 알림과  복약 현황 파악을 통해 복약 순응도를 높일 수 있습니다.",
  ),
  SurveyModel(
    title: '우울증 선별 테스트',
    comment:
        '이용자의 우울 여부는 일상생활의 동기부여 나 의약품 복약 준수도에 영향을 미칠 수 있습니다. 이용자의 상태를 파악하여 심리 상담 등 도움을 드릴 수 있습니다.',
    iconPath: 'assets/icons/circle_2.svg',
    time: '3',
    isCompleted: false,
    // 12개의 질문만들기
    questions: List<QuestionModel>.generate(
      9,
      (index) => QuestionModel(
        question: questionsDepressionScreening[index],
        options: ['전혀없음', '2~6일', '7일 이상', '거의 매일'],
        scores: [0, 1, 2, 3],
      ),
    ),
    totalScore: 0,
    resultComment: '',
    resultDescription:
        "총점이 10점 이상으로 주요우울장애가 의심되거나9번 문항을 1점 이상으로 응답한 경우  (즉, 자살/자해 생각이 있는 경우) 가까운 병∙ 의원에서 진료를 받거나, 정신건강복지센터(또는 정신건강 위기상담전화)에서 상담을 받을 필요가 있습니다. 가벼운 우울상태인 이용자들은  규칙적인 생활습관과 충분한 수면, 그리고 운동하는 습관을 통해 개선될 수 있습니다.",
  ),
  SurveyModel(
    title: '불면증 심각도 테스트',
    comment: '이용자의 불면증에 해당하는지 여부를 파악하여 수면 건강 및 전체적인 건강에 도움을 드리기 위한 설문입니다.',
    iconPath: 'assets/icons/circle_3.svg',
    time: '3',
    isCompleted: false,
    // 12개의 질문만들기
    questions: List<QuestionModel>.generate(
      9,
      (index) => QuestionModel(
        question: questionsDepressionScreening[index],
        options: ["매우", "그렇다", "보통", "아니다", "전혀 아니다"],
        scores: [0, 1, 2, 3, 4],
      ),
    ),
    totalScore: 0,
    resultComment: '',
    resultDescription:
        "충분한 수면과 좋은 수면의 질은 이용자의 건강에 중요한 요소입니다. 이 설문에서 높은 점수를 받을수록 불면증이 심한 상태이기 때문에 수면 클리닉이나 의료기관을 방문하여 적절한 치료가 필요합니다.",
  ),
];
