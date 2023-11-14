import 'package:get/get.dart';

class AddDoseReviewViewModel extends GetxController {
  RxBool isModificationMode = false.obs;
  RxBool isLoading = false.obs;
  RxBool isOcr = false.obs;

  void switchMode() {
    isModificationMode.value = !isModificationMode.value;
  }

  void setIsLoading(bool isLoading) {
    this.isLoading.value = isLoading;
  }

  void setIsOcr(bool isOcr) {
    this.isOcr.value = isOcr;
  }
}
