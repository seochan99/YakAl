import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/enum/mode.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';

class UserInfoMiddleware extends GetMiddleware {
  final userViewModel = Get.put(UserViewModel(), permanent: true);

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    var storage = const FlutterSecureStorage();

    final accessToken = await storage.read(key: 'ACCESS_TOKEN');

    if (accessToken == null) {
      return Get.rootDelegate.toNamed("/login");
    }

    if (userViewModel.user.value.isAgreedMarketing == null) {
      return Get.rootDelegate.toNamed("/login/terms");
    }

    if (userViewModel.user.value.nickName == "") {
      return Get.rootDelegate.toNamed("/login/nickname");
    }

    if (userViewModel.user.value.mode == EMode.NONE) {
      return Get.rootDelegate.toNamed("/login/mode");
    }

    return await super.redirectDelegate(route);
  }
}
