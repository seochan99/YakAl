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
import 'package:yakal/screens/Login/LoginProcess/screen.dart';
import 'package:yakal/utilities/enum/login_process.dart';
import 'package:yakal/widgets/Base/back_confirm_dialog.dart';

enum LoginRoute {
  terms,
  identifyEntry,
  identifyResult,
  nicknameInput,
  setNickname,
  modeSelection,
  setMode,
  finish;

  static void Function() back(int routeIndex, BuildContext context) {
    var routeItem = LoginRoute.values[routeIndex];

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
        return () {};
      case LoginRoute.nicknameInput:
        return () {};
      case LoginRoute.setNickname:
        return () {};
      case LoginRoute.modeSelection:
        return () {};
      case LoginRoute.setMode:
        return () {};
      case LoginRoute.finish:
        return () {};
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
        return const NicknameInputScreen();
      case LoginRoute.setNickname:
        return SetNicknameScreen();
      case LoginRoute.modeSelection:
        return const ModeSelectionScreen();
      case LoginRoute.setMode:
        return SetModeScreen();
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
      case LoginRoute.setNickname:
        return ELoginProcess.NICKNAME;
      case LoginRoute.modeSelection:
        return ELoginProcess.SELECT_MODE;
      case LoginRoute.setMode:
        return ELoginProcess.SELECT_MODE;
      case LoginRoute.finish:
        return ELoginProcess.FINISHED;
      default:
        assert(false, "🚨 [Assertion Error] Invalid Login Route Enum Value.");
    }
    return ELoginProcess.FINISHED;
  }
}
