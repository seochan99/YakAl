import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
