import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/LoginProcess/IdentificationEntry/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/IdentificationResult/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/LoginFinished/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/LoginTerms/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/ModeSelection/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/NicknameInput/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/SetMode/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/SetNickname/screen.dart';
import 'package:yakal/utilities/enum/login_process.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/back_confirm_dialog.dart';
import 'package:yakal/widgets/Login/animated_indexed_stack.dart';
import 'package:yakal/widgets/Login/login_app_bar.dart';

class LoginProcess extends StatelessWidget {
  final routeController = Get.put(LoginBeforeIdentifyController());

  LoginProcess({super.key});

  void Function() _onPressedBackInTerms(BuildContext context) {
    return () {
      showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
        builder: (BuildContext context) {
          return const BackConfirmDialog(
            question: "다시 로그인하시겠습니까?",
            backTo: "/login",
          );
        },
      );
    };
  }

  void _onPressedBackInIdentificationEntry() {
    routeController.goToTerms();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var index = routeController.routeIndex.value;

        return Container(
          color: ColorStyles.white,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: ColorStyles.white,
              appBar: LoginAppBar(
                onPressed: index == 0
                    ? _onPressedBackInTerms(context)
                    : _onPressedBackInIdentificationEntry,
                progress:
                    index == 0 ? ELoginProcess.TERMS : ELoginProcess.IDENTIFY,
              ),
              body: AnimatedIndexedStack(
                index: index,
                children: [
                  index == 0 ? const LoginTermsScreen() : Container(),
                  index == 1 ? IdentificationEntryScreen() : Container(),
                  index == 2 ? const IdentificationResultScreen() : Container(),
                  index == 3 ? const NicknameInputScreen() : Container(),
                  index == 4 ? SetNicknameScreen() : Container(),
                  index == 5 ? const ModeSelectionScreen() : Container(),
                  index == 6 ? SetModeScreen() : Container(),
                  index == 7 ? const LoginFinishedScreen() : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LoginBeforeIdentifyController extends GetxController {
  RxInt routeIndex = 0.obs;

  void goToTerms() {
    routeIndex.value = 0;
  }

  void goToIdentifyEntry() {
    routeIndex.value = 1;
  }

  void goToIdentificationResult() {
    routeIndex.value = 2;
  }

  void goToInputNickname() {
    routeIndex.value = 3;
  }

  void goToSetNickname() {
    routeIndex.value = 4;
  }

  void goToModeSelection() {
    routeIndex.value = 5;
  }

  void goToSetMode() {
    routeIndex.value = 6;
  }

  void goToLoginFinish() {
    routeIndex.value = 7;
  }

  void back() {
    if (routeIndex.value > 0) {
      routeIndex.value -= 1;
    }
  }
}
