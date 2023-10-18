class AtcCode {
  final String code;
  final int? score;

  AtcCode({required this.code, required this.score});

  factory AtcCode.fromJson(Map<String, dynamic> data) {
    return AtcCode(
      code: data['atcCode'],
      score: data['score'],
    );
  }
}
