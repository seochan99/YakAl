// DrugInfo
class DrugInfo {
  final String identaImage;
  final List<Pictogram>? pictogram;
  final String briefMonoContraIndication;
  final String briefMonoSpecialPrecaution;
  final String briefMono;
  final String briefIndication;
  final String interaction;

  DrugInfo({
    required this.identaImage,
    this.pictogram,
    required this.briefMonoContraIndication,
    required this.briefMonoSpecialPrecaution,
    required this.briefMono,
    required this.briefIndication,
    required this.interaction,
  });
  factory DrugInfo.fromJson(Map<String, dynamic> json) {
    return DrugInfo(
      identaImage: json['IdentaImage'] ?? "",
      pictogram: (json['Pictogram'] as List<dynamic>?)
          ?.map((item) => Pictogram.fromJson(item as Map<String, dynamic>))
          .toList(),
      briefMonoContraIndication: json['BriefMonoContraIndication'] ?? "",
      briefMonoSpecialPrecaution: json['BriefMonoSpecialPrecaution'] ?? "",
      briefMono: json['BriefMono'] ?? "",
      briefIndication: json['BriefIndication'] ?? "",
      interaction: json['Interaction'] ?? "",
    );
  }
}

// Pictogram
class Pictogram {
  final String image;
  final String description;

  Pictogram({
    required this.image,
    required this.description,
  });

  factory Pictogram.fromJson(Map<String, dynamic> json) {
    return Pictogram(
      image: json['Image'] ?? "",
      description: json['Description'] ?? "",
    );
  }
}
