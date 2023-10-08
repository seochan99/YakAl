import 'package:yakal/models/Medication/envelop_ocr_item_model.dart';

class EnvelopOcrGroupModel {
  List<EnvelopOcrItemModel> doseList;
  final List<bool> takingTime;

  EnvelopOcrGroupModel({
    required this.doseList,
    required this.takingTime,
  });
}
