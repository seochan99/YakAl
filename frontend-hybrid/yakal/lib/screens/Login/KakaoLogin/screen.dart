import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:yakal/screens/Login/LoginBeforeIdentify/screen.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';

import '../../../utilities/style/color_styles.dart';

class KakaoLoginScreen extends StatefulWidget {
  const KakaoLoginScreen({super.key});

  @override
  State<KakaoLoginScreen> createState() => _KakaoLoginScreenState();
}

class _KakaoLoginScreenState extends State<KakaoLoginScreen> {
  final userViewModel = Get.put(UserViewModel(), permanent: true);
  final routeController = Get.put(LoginBeforeIdentifyController());

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

  Future<void> _login() async {
    var isSuccess = await _kakaoLogin();

    if (isSuccess) {
      if (!context.mounted) {
        return;
      }

      await userViewModel.fetchNameAndMode(context);

      if (userViewModel.user.value.isAgreedMarketing == null) {
        routeController.goToTerms();
        Get.offNamed("/login/test");
        return;
      }

      final regex = RegExp(r'user#\d{6}');
      if (regex.hasMatch(userViewModel.user.value.nickName)) {
        Get.offNamed("/login/nickname");
        return;
      }

      Get.offNamed("/");
    } else {
      Get.back();

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

  @override
  void initState() {
    super.initState();
    _login();
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
