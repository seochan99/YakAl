class SearchMedicineModel {
  final String name;
  final String code;

  SearchMedicineModel({required this.name, required this.code});

  factory SearchMedicineModel.fromJson(Map<String, dynamic> json) {
    return SearchMedicineModel(name: json['Name'], code: json['Code']);
  }
}
