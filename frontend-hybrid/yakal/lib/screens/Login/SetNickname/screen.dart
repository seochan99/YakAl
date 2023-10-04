import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';

import '../../../utilities/api/api.dart';
import '../../../viewModels/Profile/user_view_model.dart';

class SetNicknameScreen extends StatefulWidget {
  const SetNicknameScreen({super.key});

  @override
  State<SetNicknameScreen> createState() => _SetNicknameScreenState();
}

class _SetNicknameScreenState extends State<SetNicknameScreen> {
  Future<void> _setNickname(BuildContext context) async {
    var dio = await authDio(context);
    var response =
        await dio.patch("/user/name", data: {"nickname": Get.arguments});
    var isSuccess = response.statusCode == 200;

    if (isSuccess) {
      UserViewModel userViewModel = Get.put(UserViewModel());
      userViewModel.updateNickName(Get.arguments);

      Get.offNamed("/login/mode");
      return;
    } else {
      Get.back();

      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('닉네임 설정에 실패했습니다.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _setNickname(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorStyles.white,
      body: Center(
        child: CircularProgressIndicator(
          color: ColorStyles.main,
        ),
      ),
    );
  }
}
