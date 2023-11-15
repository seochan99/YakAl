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
}
