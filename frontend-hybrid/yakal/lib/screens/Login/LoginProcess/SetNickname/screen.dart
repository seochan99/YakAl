import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/LoginProcess/screen.dart';
import 'package:yakal/utilities/api/api.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';

class SetNicknameScreen extends StatefulWidget {
  final UserViewModel userViewModel = Get.put(UserViewModel(), permanent: true);
  final routeController = Get.put(LoginBeforeIdentifyController());

  SetNicknameScreen({super.key});

  @override
  State<SetNicknameScreen> createState() => _SetNicknameScreenState();
}

class _SetNicknameScreenState extends State<SetNicknameScreen> {
  Future<void> _setNickname(BuildContext context) async {
    var dio = await authDio(context);

    try {
      var response =
          await dio.patch("/user/name", data: {"nickname": Get.arguments});

      widget.userViewModel.updateNickName(Get.arguments);
      widget.routeController.goToModeSelection();

      Get.offNamed("/login/process");
      return;
    } on DioException catch (error) {
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
