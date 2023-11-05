import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/models/Medication/dose_group_model.dart';
import 'package:yakal/models/Medication/dose_item_model.dart';
import 'package:yakal/models/Medication/dose_name_code_model.dart';
import 'package:yakal/models/Medication/search_medicine_model.dart';
import 'package:yakal/provider/Medicine/add_modicine_provider.dart';
import 'package:yakal/provider/Medicine/envelop_analysis_provider.dart';
import 'package:yakal/provider/Medicine/medication_direct_provider.dart';
import 'package:yakal/repository/Medicine/medicne_code_repository.dart';
import 'package:yakal/utilities/enum/add_schedule_result.dart';

class DoseListViewModel extends GetxController {
  final MedicationDirectProvider _medicationDirectProvider =
      MedicationDirectProvider();
  final AddMedicineProvider _addMedicineProvider = AddMedicineProvider();
  final EnvelopAnalysisProvider _envelopAnalysisProvider =
      EnvelopAnalysisProvider();
  final MedicineCodeRepository _medicineCodeRepository =
      MedicineCodeRepository();

  final RxList<DoseGroupModel> _groupList = <DoseGroupModel>[].obs;
  final RxList<DoseItemModel> _notAddableList = <DoseItemModel>[].obs;

  Future<bool> getMedicineInfoFromImagePath(String imagePath) async {
    var medicationList =
        await _envelopAnalysisProvider.getTextFromImage(imagePath);

    if (medicationList.isEmpty) {
      return false;
    }

    var futures = <Future<List<SearchMedicineModel>>>[];
    var names = <String>[];

    for (var medication in medicationList) {
      futures.add(
        _medicationDirectProvider.searchMedicine(medication.name),
      );
    }

    List<List<SearchMedicineModel>> searchList = await Future.wait(futures);
    var doseNameCodeList = <Map<String, String>>[];

    for (var i = 0; i < searchList.length; ++i) {
      var searchItem = searchList[i];

      if (searchItem.isEmpty) {
        doseNameCodeList.add({
          "name": names[i],
          "code": "",
        });
      } else {
        doseNameCodeList.add({
          "name": names[i],
          "code": searchItem[0].code,
        });
      }
    }

    setGroupList(doseNameCodeList);

    return true;
  }

  void setGroupList(List<Map<String, String>> doseNameCodeList) {
    var doseList = <DoseItemModel>[];

    for (var nameCode in doseNameCodeList) {
      doseList.add(
        DoseItemModel(
          name: nameCode["name"] as String,
          kimsCode: nameCode["code"] as String,
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

  Future<void> getImages() async {
    List<Future<String?>> futures = [];
    List<DoseItemModel> doseList = [];

    for (var group in _groupList) {
      for (var dose in group.doseList) {
        doseList.add(dose);
        // 킴스코드가 없으면 빈 문자열을 추가
        futures.add(dose.kimsCode == ""
            ? Future<String?>.value("")
            : _addMedicineProvider.getMedicineBase64Image(dose.kimsCode));
      }
    }

    List<String?> base64images = await Future.wait(futures);

    for (var i = 0; i < base64images.length; ++i) {
      doseList[i].base64Image = base64images[i] == "" ? null : base64images[i];
    }

    _groupList.refresh();
  }

  Future<void> getCode() async {
    List<Future<DoseNameCodeModel?>> futures = [];
    List<DoseItemModel> doseList = [];

    for (var group in _groupList) {
      for (var dose in group.doseList) {
        doseList.add(dose);
        futures.add(_medicineCodeRepository.getKDCodeAndATCCode(dose.name));
      }
    }

    List<DoseNameCodeModel?> codeList = await Future.wait(futures);

    if (kDebugMode) {
      print("📛 [Result Of Searching Medicine Code] $codeList");
    }

    for (var i = 0; i < codeList.length; ++i) {
      if (codeList[i] != null) {
        doseList[i].atcCode = codeList[i]!.atcCode;
        doseList[i].kdCode = codeList[i]!.kdCode;
      } else {
        doseList[i].atcCode = "";
        doseList[i].kdCode = "";
      }
    }

    _notAddableList.clear();

    var newGroupList = <DoseGroupModel>[];
    for (var group in _groupList) {
      var newGroup = DoseGroupModel(
        doseList: [],
        takingTime: group.takingTime.toList(),
      );

      newGroupList.add(newGroup);

      var doseList = <DoseItemModel>[];
      for (var dose in group.doseList) {
        if (dose.atcCode == "" || dose.kdCode == "") {
          _notAddableList.add(dose);
        } else {
          doseList.add(dose);
        }
      }

      if (doseList.isEmpty) {
        newGroupList.remove(newGroup);
      } else {
        newGroup.doseList = doseList;
      }
    }

    _groupList.clear();
    _groupList.addAll(newGroupList);

    _groupList.refresh();
    _notAddableList.refresh();
  }

  Future<EAddScheduleResult> addSchedule(DateTime start, DateTime end) async {
    var prescriptionId = await _addMedicineProvider.getDefaultPrescriptionId();

    if (kDebugMode) {
      print("[Read Prescription Id] $prescriptionId");
    }

    print("prescriptionId: $prescriptionId");

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
