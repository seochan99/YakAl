class DoseManagementProvider {
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
    final result = await Future.wait([
      Future.value([
        {"id": 1, "name": "동화디트로판정"},
        {"id": 2, "name": "아낙정"},
        {"id": 3, "name": "세토판정"},
        {"id": 4, "name": "아세트아미노펜"},
      ]),
      Future.delayed(const Duration(seconds: 1)),
    ]);

    return result[0];
  }
}
