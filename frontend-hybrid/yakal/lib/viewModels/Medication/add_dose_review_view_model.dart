import 'package:get/get.dart';

class AddDoseReviewViewModel extends GetxController {
  RxBool isModificationMode = false.obs;
  RxBool isLoading = false.obs;

  void switchMode() {
    isModificationMode.value = !isModificationMode.value;
  }

  void setIsLoading(bool isLoading) {
    this.isLoading.value = isLoading;
  }
}
