import 'package:flutter/material.dart';
import 'package:yakal/screens/Login/LoginProcess/IdentificationEntry/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/IdentificationResult/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/LoginFinished/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/LoginTerms/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/ModeSelection/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/NicknameInput/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/SetMode/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/SetNickname/screen.dart';

enum LoginRoute {
  terms,
  identifyEntry,
  identifyResult,
  nicknameInput,
  setNickname,
  modeSelection,
  setMode,
  finish;

  Widget get route {
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
}
