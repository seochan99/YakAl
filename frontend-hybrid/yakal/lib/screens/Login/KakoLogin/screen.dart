import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../../../utilities/style/color_styles.dart';

class KakaoLoginScreen extends StatefulWidget {
  const KakaoLoginScreen({super.key});

  @override
  State<KakaoLoginScreen> createState() => _KakaoLoginScreenState();
}

class _KakaoLoginScreenState extends State<KakaoLoginScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> _kakaoLoginByAccessToken(String accessToken) async {
    var dio = Dio();

    dio.options.headers["authorization"] = accessToken;

    try {
      var tokenResponse = await dio.post(
        "${dotenv.get("YAKAL_SERVER_HOST", fallback: "http://localhost:8080/api/v1")}/auth/kakao",
      );

      final newAccessToken = tokenResponse.data.data.accessToken as String;
      final newRefreshToken = tokenResponse.data.data.refreshToken as String;

      const storage = FlutterSecureStorage();

      await storage.write(key: 'ACCESS_TOKEN', value: newAccessToken);
      await storage.write(key: 'REFRESH_TOKEN', value: newRefreshToken);

      if (kDebugMode) {
        print("🎉 Successfully logged in to Kakao!");
      }

      return true;
    } catch (error) {
      if (kDebugMode) {
        print("🚨 [Kakao login failed] kakao access token to yakal token");
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
          print("🚨 [Kakao login failed] get kakao access token");
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
            print("🚨 [Kakao login failed] get kakao access token");
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
          print("🚨 [Kakao login failed] get kakao access token");
        }

        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _kakaoLogin(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            Get.offNamed("/login/identify/entry");
          } else {
            Get.back();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('키키오 로그인에 실패했습니다.'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        }

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: ColorStyles.white,
          body: const Center(
            child: CircularProgressIndicator(
              color: ColorStyles.main,
            ),
          ),
        );
      },
    );
  }
}
