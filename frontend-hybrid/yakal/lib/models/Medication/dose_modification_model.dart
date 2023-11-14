import 'package:yakal/models/Medication/dose_item_model.dart';

class DoseModificationItemModel {
  final DoseItemModel item;
  final int groupIndex;
  final int itemIndex;
  final List<bool> takingTime;

  DoseModificationItemModel({
    required this.item,
    required this.groupIndex,
    required this.itemIndex,
    required this.takingTime,
  });
}
