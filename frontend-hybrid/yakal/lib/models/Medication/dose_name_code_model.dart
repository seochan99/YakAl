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
}
