import 'package:get/get.dart';

import '../../models/Profile/user.dart';
import '../../utilities/enum/mode.dart';

class UserViewModel extends GetxController {
  var user = User().obs;

  void updateNickName(String newNickName) {
    user.update((val) {
      val?.setNickname(newNickName);
    });
  }

  void updateMode(EMode newMode) {
    user.update((val) {
      val?.setMode(newMode);
    });
  }
}
