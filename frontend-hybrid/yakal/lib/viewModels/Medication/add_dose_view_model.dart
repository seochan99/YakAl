import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/models/Medication/dose_group_model.dart';
import 'package:yakal/models/Medication/dose_item_model.dart';
import 'package:yakal/models/Medication/dose_modification_model.dart';
import 'package:yakal/provider/Medicine/add_medicine_provider.dart';
import 'package:yakal/provider/Medicine/envelop_analysis_provider.dart';
import 'package:yakal/utilities/enum/add_schedule_result.dart';

class AddDoseViewModel extends GetxController {
  final AddMedicineProvider _addMedicineProvider = AddMedicineProvider();
  final EnvelopAnalysisProvider _envelopAnalysisProvider =
      EnvelopAnalysisProvider();

  final RxList<DoseGroupModel> groupList = <DoseGroupModel>[].obs;

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

    groupList.clear();
    groupList.add(
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

    groupList.refresh();

    return true;
  }

  Future<void> setOneItem(String name, String kimsCode) async {
    final base64Image =
        await _addMedicineProvider.getMedicineBase64Image(kimsCode);

    groupList.clear();
    groupList.add(
      DoseGroupModel(
        doseList: [
          DoseItemModel(
            name: name,
            kdCode: "",
            atcCode: "",
            base64Image: base64Image ?? "",
          ),
        ],
        takingTime: [
          true,
          true,
          true,
          false,
        ],
      ),
    );

    groupList.refresh();
  }

  void deleteItem(int groupIndex, int itemIndex) {
    groupList[groupIndex].doseList.removeAt(itemIndex);

    if (groupList[groupIndex].doseList.isEmpty) {
      groupList.removeAt(groupIndex);
    }
  }

  void clear() {
    groupList.clear();
  }

  List<DoseGroupModel> getGroupList() {
    return groupList;
  }

  bool canSend() {
    for (var group in groupList) {
      for (var i = 0; i < 4; ++i) {
        if (group.takingTime[i] && group.doseList.isNotEmpty) {
          return true;
        }
      }
    }

    return false;
  }

  int getItemCountOnGroup(int index) {
    if (index < 0 || groupList.length <= index) {
      return -1;
    }

    return groupList[index].doseList.length;
  }

  int getGroupCount() {
    return groupList.length;
  }

  void toggle(
      int groupIndex, int itemIndex, ETakingTime takingTime, bool toBeTake) {
    var isTaking = groupList[groupIndex].takingTime[takingTime.index];

    if (isTaking == toBeTake) {
      return;
    }

    var takingTimes = groupList[groupIndex].takingTime.toList();
    takingTimes[takingTime.index] = toBeTake;

    Function deepEq = const DeepCollectionEquality().equals;

    var item =
        DoseItemModel.copyWith(groupList[groupIndex].doseList[itemIndex]);

    groupList[groupIndex].doseList.removeAt(itemIndex);

    if (groupList[groupIndex].doseList.isEmpty) {
      groupList.removeAt(groupIndex);
    }

    for (var groupItem in groupList) {
      if (deepEq(groupItem.takingTime, takingTimes)) {
        groupItem.doseList.add(item);

        groupList.refresh();
        return;
      }
    }

    groupList.add(
      DoseGroupModel(
        doseList: [item],
        takingTime: takingTimes,
      ),
    );

    groupList.refresh();
  }

  List<DoseModificationItemModel> getModificationList() {
    var modificationList = <DoseModificationItemModel>[];

    var groupIndex = 0;
    var itemIndex = 0;

    for (var groupItem in groupList) {
      for (var doseItem in groupItem.doseList) {
        modificationList.add(
          DoseModificationItemModel(
            item: doseItem,
            groupIndex: groupIndex,
            itemIndex: itemIndex,
            takingTime: groupItem.takingTime.toList(),
          ),
        );

        ++itemIndex;
      }
      ++groupIndex;
      itemIndex = 0;
    }

    modificationList.sort((e1, e2) => (e1.item.name).compareTo(e2.item.name));

    return modificationList;
  }

  String getGroupTimeString(int groupIndex) {
    final group = groupList[groupIndex];

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
    return groupList[groupIndex].doseList[itemIndex];
  }

  bool getHasCode(int groupIndex, int itemIndex) {
    var item = groupList[groupIndex].doseList[itemIndex];
    return item.kdCode != "" && item.atcCode != "";
  }

  Future<EAddScheduleResult> addSchedule(
    DateTime start,
    DateTime end,
    bool isOcr,
  ) async {
    late EAddScheduleResult result;

    if (isOcr) {
      result = await _addMedicineProvider.addSchedule(groupList, start, end);
    } else {
      final codeNameModel = await _addMedicineProvider
          .getCodeFromName(groupList[0].doseList[0].name);

      result = await _addMedicineProvider.addDirectOneSchedule(
          codeNameModel.atcCode != "" && codeNameModel.kdCode != "",
          DoseGroupModel(
            doseList: [
              DoseItemModel(
                  name: groupList[0].doseList[0].name,
                  kdCode: codeNameModel.kdCode,
                  atcCode: codeNameModel.atcCode,
                  base64Image: groupList[0].doseList[0].base64Image)
            ],
            takingTime: groupList[0].takingTime,
          ),
          start,
          end);
    }

    if (kDebugMode) {
      print("[Result Of Adding Schedule] $result");
    }

    return result;
  }
}
