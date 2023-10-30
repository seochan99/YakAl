import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
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

  bool get isiOS =>
      foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

  Future<bool> _kakaoLoginByAccessToken(String accessToken) async {
    var dio = Dio();

    dio.options.headers["authorization"] = "Bearer $accessToken";

    try {
      var tokenResponse = await dio.post(
        "${dotenv.get("YAKAL_SERVER_HOST")}/auth/kakao",
      );

      final newAccessToken =
          tokenResponse.data["data"]["accessToken"] as String;
      final newRefreshToken =
          tokenResponse.data["data"]["refreshToken"] as String;

      const storage = FlutterSecureStorage();

      await storage.write(key: 'ACCESS_TOKEN', value: newAccessToken);
      await storage.write(key: 'REFRESH_TOKEN', value: newRefreshToken);

      if (kDebugMode) {
        print("🎉 Successfully logged in to Kakao!");
      }

      return true;
    } catch (error) {
      if (kDebugMode) {
        print("🚨 [Kakao login failed] $error");
      }

      return false;
    }
  }

  Future<bool> _kakaoLogin() async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();

        return await _kakaoLoginByAccessToken(token.accessToken);
      } catch (error) {
        if (kDebugMode) {
          print("🚨 [Kakao login failed] $error");
        }

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return false;
        }

        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();

          return await _kakaoLoginByAccessToken(token.accessToken);
        } catch (error) {
          if (kDebugMode) {
            print("🚨 [Kakao login failed] $error");
          }

          return false;
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();

        return await _kakaoLoginByAccessToken(token.accessToken);
      } catch (error) {
        if (kDebugMode) {
          print("🚨 [Kakao login failed] $error");
        }

        return false;
      }
    }
  }

  Future<void> _login(ELoginPlatform loginPlatform) async {
    late bool isSuccess;

    switch (loginPlatform) {
      case ELoginPlatform.KAKAO:
        isSuccess = await _kakaoLogin();
        break;
      case ELoginPlatform.GOOGLE:
        break;
      case ELoginPlatform.APPLE:
        break;
    }

    if (isSuccess) {
      if (!context.mounted) {
        return;
      }

      await userViewModel.fetchNameAndMode(context);

      routeController.goto(LoginRoute.terms);
      Get.toNamed("/login/process");

      if (userViewModel.user.value.isAgreedMarketing == null) {
        routeController.goto(LoginRoute.terms);
        Get.toNamed("/login/process");
        return;
      }

      final regex = RegExp(r'user#\d{6}');
      if (regex.hasMatch(userViewModel.user.value.nickName)) {
        routeController.goto(LoginRoute.nicknameInput);
        Get.toNamed("/login/process");
        return;
      }

      Get.offAllNamed("/");
    } else {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('키키오 로그인에 실패했습니다.'),
          duration: Duration(seconds: 3),
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
                            _showComingSoonSnackBar(context);
                          },
                        )
                      : SocialLoginButton(
                          text: "Google 계정으로 로그인",
                          color: ColorStyles.black,
                          backgroundColor: ColorStyles.white,
                          iconPath: "assets/icons/google.svg",
                          onPressed: () async {
                            final GoogleSignInAccount? googleUser =
                                await GoogleSignIn().signIn();
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
