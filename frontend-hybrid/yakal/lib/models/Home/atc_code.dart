class AtcCode {
  final String code;
  final int score;

  AtcCode({required this.code, required this.score});

  factory AtcCode.fromJson(Map<String, dynamic>? data) {
    if (data == null) {
      return AtcCode(
        code: "",
        score: 0,
      );
    } else {
      return AtcCode(
        code: data['code'],
        score: data['score'],
      );
    }
  }
}
