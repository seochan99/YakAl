import 'package:yakal/models/Medication/envelop_ocr_item_model.dart';

class EnvelopOcrGroupModel {
  final List<EnvelopOcrItemModel> doseList;
  final List<bool> takingTime;

  const EnvelopOcrGroupModel({
    required this.doseList,
    required this.takingTime,
  });
}
