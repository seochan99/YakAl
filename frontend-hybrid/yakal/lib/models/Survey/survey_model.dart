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
          resultComment = '우울증상이 없습니다';
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
  SurveyModel(
    title: '우울증 선별 테스트',
    comment:
        '이용자의 우울 여부는 일상생활의\n동기부여 나 의약품 복약 준수도에\n영향을 미칠 수 있습니다. \n이용자의 상태를 파악하여\n심리 상담 등 도움을 드릴 수 있습니다.',
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
        "총점이 10점 이상으로 주요우울장애가 의심되거나9번 문항을 1점 이상으로 응답한 경우\n (즉, 자살/자해 생각이 있는 경우) 가까운 병∙ 의원에서 진료를 받거나, 정신건강복지센터(또는 정신건강 위기상담전화)에서 상담을 받을 필요가 있습니다.\n가벼운 우울상태인 이용자들은 \n규칙적인 생활습관과 충분한 수면, 그리고 운동하는 습관을 통해 개선될 수 있습니다.",
  ),
];

// questionsBokyak
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

// question 우울증 선별검사
const List<String> questionsDepressionScreening = [
  "일을 하는 것에 대한 흥미나 재미가 거의 없음",
  "가라앉는 느낌, 우울감 또는 절망감",
  "잠들기 어렵거나 자꾸 깨어남, 혹은 너무 많이 잠",
  "피곤함, 기력이 저하됨",
  "식욕 저하 혹은 과식",
  "내 자신이 나쁜 사람이라는 느낌 혹은 나 때문에 내 주변이 불행하게 되었다는 느낌",
  "신문을 읽거나 TV를 볼 때 집중하기 어려움",
  "남들이 알아챌 정도로 거동이나 말이 느림 또는 안절부절못해서 평소보다 많이 돌아다님",
  "차라리 죽는 것이 낫겠다는 생각 혹은 어떤 식으로든 스스로를 자해하는 생각들"
];
