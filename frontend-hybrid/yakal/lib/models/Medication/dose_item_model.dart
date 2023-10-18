class DoseItemModel {
  final String name;
  final String code;
  late String? base64Image;

  DoseItemModel({
    required this.name,
    required this.code,
    required this.base64Image,
  });

  factory DoseItemModel.copyWith(DoseItemModel envelopOcrItemModel) {
    return DoseItemModel(
      name: envelopOcrItemModel.name,
      code: envelopOcrItemModel.code,
      base64Image: envelopOcrItemModel.base64Image,
    );
  }
}
