import 'package:flutter/foundation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:yakal/provider/Medicine/dose_management_provider.dart';

class PrescriptionViewModel {
  static const pageSize = 20;

  final DoseManagementProvider _doseManagementProvider =
      DoseManagementProvider();
  final PagingController<int, int> pagingController =
      PagingController(firstPageKey: 0);

  void init() {
    pagingController.addPageRequestListener((pageKey) {
      if (kDebugMode) {
        print(
            "♻️ [Prescription Page Request Invoked] pageSize : $pageSize | pageKey : $pageKey");
      }
      fetchPage(pageKey);
    });
  }

  void dispose() {
    pagingController.dispose();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final newItems =
          await _doseManagementProvider.getPrescriptionList(pageKey, pageSize);

      final isLastPage = newItems.length < pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      if (kDebugMode) {
        print("🚨 [Prescription Page Request Error] $error");
      }

      pagingController.error = error;
    }
  }
}
