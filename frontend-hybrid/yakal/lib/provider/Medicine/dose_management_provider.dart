import 'package:yakal/provider/Medicine/add_medicine_provider.dart';

class DoseManagementProvider {
  final AddMedicineProvider _addMedicineProvider = AddMedicineProvider();

  Future<List<int>> getPrescriptionList(int pageKey, int pageSize) async {
    if (pageKey == 80) {
      final result = await Future.wait([
        Future.value(<int>[]),
        Future.delayed(const Duration(seconds: 1)),
      ]);

      return result[0];
    }

    final result = await Future.wait([
      Future.value(List.generate(20, (index) => pageKey + index)),
      Future.delayed(const Duration(seconds: 1))
    ]);

    return result[0];
  }

  Future<List> getDoseList(int prescriptionId) async {
    final doseList = [
      {"id": 1, "name": "동화디트로판정5mg", "base64Image": null},
      {"id": 2, "name": "아낙정", "base64Image": null},
      {"id": 3, "name": "세토펜정", "base64Image": null},
      {"id": 4, "name": "가나릴정", "base64Image": null},
    ];
    List<Future<String?>> futures = [];

    for (var i = 0; i < doseList.length; ++i) {
      futures.add(_addMedicineProvider
          .getBase64ImageFromName(doseList[i]["name"] as String));
    }

    final base64Images = await Future.wait(futures);

    for (var i = 0; i < doseList.length; ++i) {
      doseList[i]["base64Image"] = base64Images[i];
    }

    return doseList;
  }
}
