class DoseNameCodeModel {
  String name;
  String atcCode;
  String kdCode;

  DoseNameCodeModel({
    required this.name,
    required this.atcCode,
    required this.kdCode,
  });

  @override
  String toString() {
    return "{name: $name, atcCode: $atcCode, kdCode: $kdCode}";
  }

  factory DoseNameCodeModel.fromJson(Map<String, dynamic> json) {
    return DoseNameCodeModel(
      name: json["doseName"],
      atcCode: json["atcCode"],
      kdCode: json["kdCode"],
    );
  }
}
