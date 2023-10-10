import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/models/Medication/envelop_cor_group_model.dart';
import 'package:yakal/models/Medication/envelop_ocr_item_model.dart';

class EnvelopOcrListViewModel extends GetxController {
  final RxList<EnvelopOcrGroupModel> _groupList = [
    EnvelopOcrGroupModel(
      doseList: [
        const EnvelopOcrItemModel(
          name: "올메텍플러스정20/12.5mg",
          base64Image: null,
        ),
        const EnvelopOcrItemModel(
          name: "바난정",
          base64Image: null,
        ),
        const EnvelopOcrItemModel(
          name: "레보프라이드",
          base64Image: null,
        ),
        const EnvelopOcrItemModel(
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
        const EnvelopOcrItemModel(
          name: "비졸본정",
          base64Image: null,
        ),
        const EnvelopOcrItemModel(
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

  void toggle(
      int groupIndex, int itemIndex, ETakingTime takingTime, bool toBeTake) {
    var isTaking = _groupList[groupIndex].takingTime[takingTime.index];

    if (isTaking == toBeTake) {
      return;
    }

    var takingTimes = _groupList[groupIndex].takingTime.toList();
    takingTimes[takingTime.index] = toBeTake;

    Function deepEq = const DeepCollectionEquality().equals;

    var item = EnvelopOcrItemModel.copyWith(
        _groupList[groupIndex].doseList[itemIndex]);

    _groupList[groupIndex].doseList.removeAt(itemIndex);

    if (_groupList[groupIndex].doseList.isEmpty) {
      _groupList.removeAt(groupIndex);
    }

    for (var groupItem in _groupList) {
      if (deepEq(groupItem.takingTime, takingTimes)) {
        groupItem.doseList.add(item);

        _groupList.refresh();
        return;
      }
    }

    _groupList.add(
      EnvelopOcrGroupModel(
        doseList: [item],
        takingTime: takingTimes,
      ),
    );

    _groupList.refresh();
  }
}
