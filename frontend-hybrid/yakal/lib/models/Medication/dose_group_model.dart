import 'package:yakal/models/Medication/dose_item_model.dart';

class DoseGroupModel {
  List<DoseItemModel> doseList;
  final List<bool> takingTime;

  DoseGroupModel({
    required this.doseList,
    required this.takingTime,
  });
}
