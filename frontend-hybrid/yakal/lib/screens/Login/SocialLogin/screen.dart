import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/provider/Login/social_login_provider.dart';
import 'package:yakal/screens/Login/LoginProcess/login_route.dart';
import 'package:yakal/screens/Login/LoginProcess/screen.dart';
import 'package:yakal/utilities/enum/login_platform.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Login/social_login_button.dart';

import '../../../widgets/Base/outer_frame.dart';

class SocialLoginScreen extends StatefulWidget {
  const SocialLoginScreen({super.key});

  @override
  State<SocialLoginScreen> createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {
  final userViewModel = Get.put(UserViewModel(), permanent: true);
  final routeController = Get.put(LoginRouteController());

  final socialLoginProvider = SocialLoginProvider();

  bool get isiOS =>
      foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

  Future<void> _login(ELoginPlatform loginPlatform) async {
    late bool isSuccess;

    switch (loginPlatform) {
      case ELoginPlatform.KAKAO:
        isSuccess = await socialLoginProvider.kakaoLogin();
        break;
      case ELoginPlatform.GOOGLE:
        isSuccess = await socialLoginProvider.googleLogin();
        break;
      case ELoginPlatform.APPLE:
        isSuccess = await socialLoginProvider.appleLogin();
        break;
    }

    if (isSuccess) {
      if (!context.mounted) {
        return;
      }

      await userViewModel.fetchLoginInfo();

      if (kDebugMode) {
        print(
            "[Social Login Finished] name: ${userViewModel.user.value.nickName}, isDetail: ${userViewModel.user.value.mode}, isAgreedMarketing: ${userViewModel.user.value.isAgreedMarketing}, isIdentified: ${userViewModel.user.value.isIdentified}");
      }

      if (userViewModel.user.value.isAgreedMarketing == null) {
        routeController.goto(LoginRoute.terms);
        Get.toNamed("/login/process");
        return;
      }

      if (userViewModel.user.value.isIdentified == false) {
        routeController.goto(LoginRoute.identifyEntry);
        Get.toNamed("/login/process");
        return;
      }

      Get.offAllNamed("/");
    } else {
      if (!context.mounted) {
        return;
      }

      late String message;

      switch (loginPlatform) {
        case ELoginPlatform.KAKAO:
          message = '카카오 로그인에 실패했습니다.';
          break;
        case ELoginPlatform.GOOGLE:
          message = '구글 로그인에 실패했습니다.';
          break;
        case ELoginPlatform.APPLE:
          message = '애플 로그인에 실패했습니다.';
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(message),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _showComingSoonSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('기능 준비중입니다.'),
        duration: Duration(milliseconds: 3000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OuterFrame(
      safeAreaColor: ColorStyles.gray1,
      outOfSafeAreaColor: ColorStyles.gray1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 200,
          ),
          SvgPicture.asset(
            'assets/icons/login_main.svg',
          ),
          const Spacer(),
          Container(
            color: ColorStyles.gray1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 70),
              child: Column(
                children: [
                  SocialLoginButton(
                    text: "카카오로 로그인",
                    color: ColorStyles.black,
                    backgroundColor: const Color(0xFFFEE500),
                    iconPath: "assets/icons/kakao.svg",
                    onPressed: () {
                      _login(ELoginPlatform.KAKAO);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isiOS
                      ? SocialLoginButton(
                          text: "Apple로 로그인",
                          color: ColorStyles.white,
                          backgroundColor: ColorStyles.black,
                          iconPath: "assets/icons/apple.svg",
                          onPressed: () {
                            _login(ELoginPlatform.APPLE);
                          },
                        )
                      : SocialLoginButton(
                          text: "Google 계정으로 로그인",
                          color: ColorStyles.black,
                          backgroundColor: ColorStyles.white,
                          iconPath: "assets/icons/google.svg",
                          onPressed: () async {
                            _login(ELoginPlatform.GOOGLE);
                          },
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
