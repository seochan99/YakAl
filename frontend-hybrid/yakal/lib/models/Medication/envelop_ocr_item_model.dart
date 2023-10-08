class EnvelopOcrItemModel {
  final String name;
  final String? base64Image;

  const EnvelopOcrItemModel({
    required this.name,
    required this.base64Image,
  });

  factory EnvelopOcrItemModel.copyWith(
      EnvelopOcrItemModel envelopOcrItemModel) {
    return EnvelopOcrItemModel(
      name: envelopOcrItemModel.name,
      base64Image: envelopOcrItemModel.base64Image,
    );
  }
}
