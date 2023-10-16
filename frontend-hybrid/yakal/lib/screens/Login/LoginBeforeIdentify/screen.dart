import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/IdentificationResult/screen.dart';
import 'package:yakal/screens/Login/LoginBeforeIdentify/IdentificationEntry/screen.dart';
import 'package:yakal/screens/Login/LoginBeforeIdentify/LoginTerms/screen.dart';
import 'package:yakal/screens/Login/LoginFinished/screen.dart';
import 'package:yakal/screens/Login/ModeSelection/screen.dart';
import 'package:yakal/screens/Login/NicknameInput/screen.dart';
import 'package:yakal/utilities/enum/login_process.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/back_confirm_dialog.dart';
import 'package:yakal/widgets/Base/outer_frame.dart';
import 'package:yakal/widgets/Login/animated_indexed_stack.dart';
import 'package:yakal/widgets/Login/login_app_bar.dart';

class LoginBeforeIdentifyScreen extends StatelessWidget {
  final routeController = Get.put(LoginBeforeIdentifyController());

  LoginBeforeIdentifyScreen({super.key});

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
        return OuterFrame(
          outOfSafeAreaColor: ColorStyles.white,
          safeAreaColor: ColorStyles.white,
          appBar: LoginAppBar(
            onPressed: routeController.routeIndex.value == 0
                ? _onPressedBackInTerms(context)
                : _onPressedBackInIdentificationEntry,
            progress: routeController.routeIndex.value == 0
                ? ELoginProcess.TERMS
                : ELoginProcess.IDENTIFY,
          ),
          child: Obx(
            () {
              return AnimatedIndexedStack(
                index: routeController.routeIndex.value,
                children: [
                  const LoginTermsScreen(),
                  IdentificationEntryScreen(),
                  const IdentificationResultScreen(),
                  const NicknameInputScreen(),
                  const ModeSelectionScreen(),
                  const LoginFinishedScreen(),
                ],
              );
            },
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

  void goToInputNickName() {
    routeIndex.value = 3;
  }

  void goToModeSelection() {
    routeIndex.value = 4;
  }

  void goToLoginFinish() {
    routeIndex.value = 5;
  }

  void back() {
    if (routeIndex.value > 0) {
      routeIndex.value -= 1;
    }
  }
}
