import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/enum/mode.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';

class UserInfoMiddleware extends GetMiddleware {
  final userViewModel = Get.put(UserViewModel(), permanent: true);

  @override
  RouteSettings? redirect(String? route) {
    if (userViewModel.user.value.nickName == "") {
      return const RouteSettings(name: "/login/nickname");
    }

    if (userViewModel.user.value.mode == EMode.NONE) {
      return const RouteSettings(name: "/login/mode");
    }

    if (userViewModel.user.value.isAgreedMarketing == null) {
      return const RouteSettings(name: "/login/terms");
    }

    return null;
  }
}
