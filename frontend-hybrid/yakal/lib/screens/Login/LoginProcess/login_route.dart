import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/LoginProcess/IdentificationEntry/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/IdentificationResult/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/LoginFinished/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/LoginTerms/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/ModeSelection/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/NicknameInput/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/screen.dart';
import 'package:yakal/utilities/enum/login_process.dart';
import 'package:yakal/widgets/Base/back_confirm_dialog.dart';
import 'package:yakal/widgets/Base/not_route_back_dialog.dart';

enum LoginRoute {
  terms,
  identifyEntry,
  identifyResult,
  nicknameInput,
  modeSelection,
  finish;

  static void Function()? back(int routeIndex, BuildContext context) {
    var routeItem = LoginRoute.values[routeIndex];

    final nicknameLoadingController = Get.put(NicknameInputLoadingController());

    switch (routeItem) {
      case LoginRoute.terms:
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
      case LoginRoute.identifyEntry:
        return () {
          final routeController = Get.put(LoginRouteController());
          routeController.goto(LoginRoute.terms);
        };
      case LoginRoute.identifyResult:
        return () {
          showDialog(
            context: context,
            barrierDismissible: true,
            barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
            builder: (BuildContext context) {
              return NotRouteBackConfirmDialog(
                question: "본인인증을 다시 하시겠습니까?",
                backAction: () {
                  final routeController = Get.put(LoginRouteController());
                  routeController.goto(LoginRoute.identifyEntry);
                },
              );
            },
          );
        };
      case LoginRoute.nicknameInput:
        return nicknameLoadingController.isLoading.value
            ? null
            : () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
                  builder: (BuildContext context) {
                    return NotRouteBackConfirmDialog(
                      question: "본인인증을 다시 하시겠습니까?",
                      backAction: () {
                        final routeController = Get.put(LoginRouteController());
                        routeController.goto(LoginRoute.identifyEntry);
                      },
                    );
                  },
                );
              };
      case LoginRoute.modeSelection:
        return () {};
      case LoginRoute.finish:
        return null;
      default:
        assert(false, "🚨 [Assertion Error] Invalid Login Route Enum Value.");
    }
    return () {};
  }

  Widget get screen {
    switch (this) {
      case LoginRoute.terms:
        return const LoginTermsScreen();
      case LoginRoute.identifyEntry:
        return IdentificationEntryScreen();
      case LoginRoute.identifyResult:
        return const IdentificationResultScreen();
      case LoginRoute.nicknameInput:
        return NicknameInputScreen();
      case LoginRoute.modeSelection:
        return ModeSelectionScreen();
      case LoginRoute.finish:
        return const LoginFinishedScreen();
      default:
        assert(false, "🚨 [Assertion Error] Invalid Login Route Enum Value.");
    }
    return Container();
  }

  ELoginProcess get loginProcess {
    switch (this) {
      case LoginRoute.terms:
        return ELoginProcess.TERMS;
      case LoginRoute.identifyEntry:
        return ELoginProcess.IDENTIFY;
      case LoginRoute.identifyResult:
        return ELoginProcess.IDENTIFY;
      case LoginRoute.nicknameInput:
        return ELoginProcess.NICKNAME;
      case LoginRoute.modeSelection:
        return ELoginProcess.SELECT_MODE;
      case LoginRoute.finish:
        return ELoginProcess.FINISHED;
      default:
        assert(false, "🚨 [Assertion Error] Invalid Login Route Enum Value.");
    }
    return ELoginProcess.FINISHED;
  }
}
