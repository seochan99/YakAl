import 'package:get/get.dart';
import 'package:yakal/models/Medication/envelop_cor_group_model.dart';
import 'package:yakal/models/Medication/envelop_ocr_item_model.dart';

class EnvelopOcrListViewModel extends GetxController {
  final RxList<EnvelopOcrGroupModel> _groupList = const [
    EnvelopOcrGroupModel(
      doseList: [
        EnvelopOcrItemModel(
          name: "올메텍플러스정20/12.5mg",
          base64Image: null,
        ),
        EnvelopOcrItemModel(
          name: "바난정",
          base64Image: null,
        ),
        EnvelopOcrItemModel(
          name: "레보프라이드",
          base64Image: null,
        ),
        EnvelopOcrItemModel(
          name: "싸이메트정",
          base64Image: null,
        ),
      ],
      takingTime: [
        true,
        true,
        true,
        false,
      ],
    ),
    EnvelopOcrGroupModel(
      doseList: [
        EnvelopOcrItemModel(
          name: "비졸본정",
          base64Image: null,
        ),
        EnvelopOcrItemModel(
          name: "한미아스피린장용정100mg",
          base64Image: null,
        ),
      ],
      takingTime: [
        true,
        false,
        true,
        false,
      ],
    ),
  ].obs;

  List<EnvelopOcrGroupModel> getGroupList() {
    return _groupList;
  }

  int getItemCountOnGroup(int index) {
    if (index < 0 || _groupList.length <= index) {
      return -1;
    }

    return _groupList[index].doseList.length;
  }

  int getGroupCount() {
    return _groupList.length;
  }
}
