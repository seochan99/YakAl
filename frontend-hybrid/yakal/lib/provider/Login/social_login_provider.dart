import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:yakal/utilities/enum/login_platform.dart';

class SocialLoginProvider {
  Future<bool> _loginByAccessToken(
      String accessToken, ELoginPlatform loginPlatform) async {
    var dio = Dio();

    dio.options.headers["authorization"] = "Bearer $accessToken";

    try {
      var tokenResponse = await dio.post(
        "${dotenv.get("YAKAL_SERVER_HOST")}/auth/${loginPlatform.name.toLowerCase()}",
      );

      final newAccessToken =
          tokenResponse.data["data"]["accessToken"] as String;
      final newRefreshToken =
          tokenResponse.data["data"]["refreshToken"] as String;

      const storage = FlutterSecureStorage();

      await storage.write(key: 'ACCESS_TOKEN', value: newAccessToken);
      await storage.write(key: 'REFRESH_TOKEN', value: newRefreshToken);

      if (kDebugMode) {
        print(
            "🎉 Successfully logged in to ${loginPlatform.name.toLowerCase()}!");
      }

      return true;
    } catch (error) {
      if (kDebugMode) {
        print("🚨 [${loginPlatform.name} login failed] $error");
      }

      return false;
    }
  }

  Future<bool> kakaoLogin() async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();

        return await _loginByAccessToken(
            token.accessToken, ELoginPlatform.KAKAO);
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

          return await _loginByAccessToken(
              token.accessToken, ELoginPlatform.KAKAO);
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

        return await _loginByAccessToken(
            token.accessToken, ELoginPlatform.KAKAO);
      } catch (error) {
        if (kDebugMode) {
          print("🚨 [Kakao login failed] $error");
        }

        return false;
      }
    }
  }

  Future<bool> googleLogin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    var accessToken = googleSignInAuthentication.accessToken;

    if (accessToken == null) {
      return false;
    }

    return await _loginByAccessToken(accessToken, ELoginPlatform.GOOGLE);
  }
}
