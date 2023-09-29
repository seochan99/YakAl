class QuestionModel {
  final String question;
  final List<String> options;
  final List<int> scores;

  QuestionModel({
    required this.question,
    required this.options,
    required this.scores,
  });
}
