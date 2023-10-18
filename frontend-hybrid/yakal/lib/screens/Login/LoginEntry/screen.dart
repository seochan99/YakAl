import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/LoginEntry/style.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Login/social_login_button.dart';

import '../../../widgets/Base/outer_frame.dart';

class LoginEntryScreen extends StatelessWidget {
  bool get isiOS =>
      foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

  const LoginEntryScreen({super.key});

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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "AI를 이용한 ",
                      style: LoginEntryStyle.blackSubtitle,
                    ),
                    Text(
                      "복약 도움 플랫폼",
                      style: LoginEntryStyle.blueBoldSubtitle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "약 알",
                      style: LoginEntryStyle.title,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/login_banner.png",
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                SocialLoginButton(
                  text: "카카오로 로그인",
                  color: ColorStyles.black,
                  backgroundColor: const Color(0xFFFEE500),
                  iconPath: "assets/icons/kakao.svg",
                  onPressed: () {
                    Get.toNamed("/login/kakao");
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
                        onPressed: () {
                          _showComingSoonSnackBar(context);
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
