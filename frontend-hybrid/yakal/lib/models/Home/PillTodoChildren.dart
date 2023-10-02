import 'AtcCode.dart';

class PillTodoChildren {
  final int id;
  final String base64Image;
  final String name;
  final String effect;
  final String kdCode;
  final AtcCode atcCode;
  final int count;
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
}
