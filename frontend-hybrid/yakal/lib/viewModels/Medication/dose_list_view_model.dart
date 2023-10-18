import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/models/Medication/dose_group_model.dart';
import 'package:yakal/models/Medication/dose_item_model.dart';
import 'package:yakal/provider/Medicine/add_modicine_provider.dart';

class DoseListViewModel extends GetxController {
  final AddMedicineProvider _addMedicineProvider = AddMedicineProvider();

  final RxList<DoseGroupModel> _groupList = <DoseGroupModel>[].obs;

  void setGroupList(List<Map<String, String>> doseNameCodeList) {
    var doseList = <DoseItemModel>[];

    for (var nameCode in doseNameCodeList) {
      doseList.add(
        DoseItemModel(
          name: nameCode["name"] as String,
          code: nameCode["code"] as String,
          base64Image: null,
        ),
      );
    }

    _groupList.clear();
    _groupList.add(
      DoseGroupModel(
        doseList: doseList,
        takingTime: [
          true,
          true,
          true,
          false,
        ],
      ),
    );

    _groupList.refresh();
  }

  List<DoseGroupModel> getGroupList() {
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

    var item =
        DoseItemModel.copyWith(_groupList[groupIndex].doseList[itemIndex]);

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
      DoseGroupModel(
        doseList: [item],
        takingTime: takingTimes,
      ),
    );

    _groupList.refresh();
  }

  List<dynamic> getModificationList() {
    var groupList = _groupList;
    var modificationList = [];

    var groupIndex = 0;
    var itemIndex = 0;

    for (var groupItem in groupList) {
      for (var doseItem in groupItem.doseList) {
        modificationList.add({
          "item": doseItem,
          "groupIndex": groupIndex,
          "itemIndex": itemIndex,
          "takingTime": groupItem.takingTime.toList(),
        });
        ++itemIndex;
      }
      ++groupIndex;
      itemIndex = 0;
    }

    modificationList.sort((e1, e2) =>
        (e1["item"].name as String).compareTo(e2["item"].name as String));

    return modificationList;
  }

  String getGroupTimeString(int groupIndex) {
    final group = _groupList[groupIndex];

    final totalTimeList = ETakingTime.values.sublist(0, 4);

    String groupTime = "";
    for (var takingTime in totalTimeList) {
      if (group.takingTime[takingTime.index] == true) {
        groupTime = "$groupTime, ${takingTime.time}";
      }
    }
    groupTime = groupTime.substring(", ".length);

    return groupTime;
  }

  DoseItemModel getOneMedicine(int groupIndex, int itemIndex) {
    return _groupList[groupIndex].doseList[itemIndex];
  }

  Future<void> getImages() async {
    List<Future<String?>> futures = [];
    List<DoseItemModel> doseList = [];

    for (var group in _groupList) {
      for (var dose in group.doseList) {
        doseList.add(dose);
        futures.add(_addMedicineProvider.getMedicineBase64Image(dose.code));
      }
    }

    List<String?> base64images = await Future.wait(futures);

    for (var i = 0; i < base64images.length; ++i) {
      doseList[i].base64Image = base64images[i];
    }

    _groupList.refresh();
  }
}
