import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MingamController extends GetxController {
  // '_isMingam'을 RxBool (Observable)로 변환하여 GetX에서 관찰
  final RxBool _isMingam = false.obs;

  // 외부에서 접근 가능한 getter를 제공
  bool get isMingam => _isMingam.value;

  @override
  void onInit() {
    super.onInit();
    _loadMingamStatus();
  }

  // SharedPreferences에서 'mingam' 값을 로드하여 상태를 업데이트하는 함수
  void _loadMingamStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // SharedPreferences에서 'mingam' 값을 가져옵니다. 기본값은 'false'
    _isMingam.value = prefs.getBool('mingam') ?? false;
  }

  // 사용자가 민감 정보 동의 여부를 변경할 때 호출할 수 있는 함수
  void setMingamStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('mingam', value);
    _isMingam.value = value;
  }
}
