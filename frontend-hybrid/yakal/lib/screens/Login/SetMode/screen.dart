import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/enum/mode.dart';

import '../../../utilities/api/api.dart';
import '../../../utilities/style/color_styles.dart';
import '../../../viewModels/Profile/user_view_model.dart';

class SetModeScreen extends StatefulWidget {
  final UserViewModel userViewModel = Get.put(UserViewModel(), permanent: true);

  SetModeScreen({super.key});

  @override
  State<SetModeScreen> createState() => _SetModeScreenState();
}

class _SetModeScreenState extends State<SetModeScreen> {
  Future<void> _setMode() async {
    var dio = await authDio(context);

    var response = await dio.patch("/user/detail",
        data: {"isDetail": EMode.values[Get.arguments] == EMode.LITE});
    var isSuccess = response.statusCode == 200;

    if (isSuccess) {
      widget.userViewModel
          .updateMode(EMode.values[Get.arguments] == EMode.LITE);

      Get.offNamed("/login/finish");
      return;
    } else {
      Get.back();

      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('모드 설정에 실패했습니다.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _setMode();
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
