import 'package:get/get.dart';

import 'atc_code.dart';

class PillTodoChildren {
  final int id;
  final String base64Image;
  final String name;
  final String effect;
  final String kdCode;
  final AtcCode atcCode;
  final String count;
  final bool isOverLap;
  bool isTaken;

  PillTodoChildren({
    required this.id,
    required this.base64Image,
    required this.name,
    required this.effect,
    required this.kdCode,
    required this.atcCode,
    required this.count,
    required this.isOverLap,
    required this.isTaken,
  });

  factory PillTodoChildren.fromJson(Map<String, dynamic> data) {
    return PillTodoChildren(
      id: data['id'],
      base64Image: data['base64Image'] ?? "",
      name: data['dosename'],
      effect: data['effect'] ?? "",
      kdCode: data['kdcode'],
      atcCode: AtcCode.fromJson(data['atccode']),
      count: data['count'].toString(),
      isOverLap: data['isOverlap'],
      isTaken: data['isTaken'],
    );
  }

  @override
  String toString() {
    return "id: $id, base64Image: $base64Image, name: $name, effect: $effect, kdCode: $kdCode, atcCode: $atcCode, count: $count, isOverLap: $isOverLap, isTaken: $isTaken\n";
  }
}
