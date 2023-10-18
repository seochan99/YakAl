class DoseItemModel {
  final String name;
  final String kimsCode;
  late String? kdCode;
  late String? atcCode;
  late String? base64Image;

  DoseItemModel({
    required this.name,
    required this.kimsCode,
    this.kdCode,
    this.atcCode,
    this.base64Image,
  });

  factory DoseItemModel.copyWith(DoseItemModel doseItemModel) {
    return DoseItemModel(
      name: doseItemModel.name,
      kimsCode: doseItemModel.kimsCode,
    );
  }
}
