import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/models/Medication/dose_group_model.dart';
import 'package:yakal/models/Medication/dose_item_model.dart';
import 'package:yakal/provider/Medicine/add_medicine_provider.dart';
import 'package:yakal/provider/Medicine/envelop_analysis_provider.dart';
import 'package:yakal/utilities/enum/add_schedule_result.dart';

class AddDoseViewModel extends GetxController {
  final AddMedicineProvider _addMedicineProvider = AddMedicineProvider();
  final EnvelopAnalysisProvider _envelopAnalysisProvider =
      EnvelopAnalysisProvider();

  final RxList<DoseGroupModel> _groupList = <DoseGroupModel>[].obs;
  final RxList<DoseItemModel> _notAddableList = <DoseItemModel>[].obs;

  Future<bool> getMedicineInfoFromImagePath(String imagePath) async {
    final medicationList =
        await _envelopAnalysisProvider.getDoseInfoFromImage(imagePath);

    if (medicationList.isEmpty) {
      return false;
    }

    final futuresForImage = <Future<String?>>[];

    for (var medication in medicationList) {
      futuresForImage.add(
        _addMedicineProvider.getBase64ImageFromName(medication.name),
      );
    }

    final base64Images = await Future.wait(futuresForImage);
    final doseItemList = <DoseItemModel>[];

    for (var i = 0; i < base64Images.length; ++i) {
      doseItemList.add(DoseItemModel(
        name: medicationList[i].name,
        kdCode: medicationList[i].kdCode,
        atcCode: medicationList[i].atcCode,
        base64Image: base64Images[i] ?? "",
      ));
    }

    _groupList.clear();
    _groupList.add(
      DoseGroupModel(
        doseList: doseItemList,
        takingTime: [
          true,
          true,
          true,
          false,
        ],
      ),
    );

    _groupList.refresh();

    return true;
  }

  void clear() {
    _groupList.clear();
    _notAddableList.clear();
  }

  List<DoseGroupModel> getGroupList() {
    return _groupList;
  }

  DoseItemModel getNotAddableItem(int index) {
    return _notAddableList[index];
  }

  bool canSend() {
    for (var group in _groupList) {
      for (var i = 0; i < 4; ++i) {
        if (group.takingTime[i] && group.doseList.isNotEmpty) {
          return true;
        }
      }
    }

    return false;
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

  int getNotAddableCount() {
    return _notAddableList.length;
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

    if (groupTime == "") {
      return "복용하는 시간대가 없습니다.";
    }

    groupTime = groupTime.substring(", ".length);

    return groupTime;
  }

  DoseItemModel getOneMedicine(int groupIndex, int itemIndex) {
    return _groupList[groupIndex].doseList[itemIndex];
  }

  bool getHasCode(int groupIndex, int itemIndex) {
    var item = _groupList[groupIndex].doseList[itemIndex];
    return item.kdCode != "" && item.atcCode != "";
  }

  Future<EAddScheduleResult> addSchedule(DateTime start, DateTime end) async {
    var prescriptionId = await _addMedicineProvider.getDefaultPrescriptionId();

    if (kDebugMode) {
      print("[Read Prescription Id] $prescriptionId");
    }

    if (prescriptionId == -1) {
      return EAddScheduleResult.FAIL;
    }

    var result = _addMedicineProvider.addSchedule(_groupList, 4, start, end);

    if (kDebugMode) {
      print("[Result Of Adding Schedule] $result");
    }

    return result;
  }
}
