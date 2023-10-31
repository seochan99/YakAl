// 특이사항
class SpecialNote {
  List<ItemWithNameAndId> underlyingConditions;
  List<ItemWithNameAndId> allergies;
  List<DateTime> falls;
  List<ItemWithNameAndId> diagnosis;
  List<ItemWithNameAndId> healthfood;

  SpecialNote({
    required this.underlyingConditions,
    required this.allergies,
    required this.falls,
    required this.diagnosis,
    required this.healthfood,
  });
}

class ItemWithNameAndId {
  int id;
  String name;

  ItemWithNameAndId({required this.id, required this.name});

  factory ItemWithNameAndId.fromJson(Map<String, dynamic> json) {
    return ItemWithNameAndId(
      id: json['id'],
      name: json['name'],
    );
  }
  @override
  String toString() {
    return '{ id: $id, name: "$name" }';
  }
}
