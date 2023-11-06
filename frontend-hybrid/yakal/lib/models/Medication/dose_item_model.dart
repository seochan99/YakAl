class DoseItemModel {
  final String name;
  final String kdCode;
  final String atcCode;
  final String base64Image;

  DoseItemModel({
    required this.name,
    required this.kdCode,
    required this.atcCode,
    required this.base64Image,
  });

  factory DoseItemModel.copyWith(DoseItemModel doseItemModel) {
    return DoseItemModel(
      name: doseItemModel.name,
      kdCode: doseItemModel.kdCode,
      atcCode: doseItemModel.atcCode,
      base64Image: doseItemModel.base64Image,
    );
  }
}
