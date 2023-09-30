import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Auth/social_login_button.dart';

class LoginEntryScreen extends StatelessWidget {
  bool get isiOS =>
      foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

  const LoginEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorStyles.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorStyles.white,
          body: Column(
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
                          style: TextStyle(
                            color: ColorStyles.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            height: 1.685,
                            fontFamily: "SUIT",
                          ),
                        ),
                        Text(
                          "복약 도움 플랫폼",
                          style: TextStyle(
                            color: ColorStyles.main,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.685,
                            fontFamily: "SUIT",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "약 알",
                          style: TextStyle(
                            color: ColorStyles.main,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            height: 1.6,
                            fontFamily: "SUIT",
                          ),
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
                        Get.toNamed("/login/terms");
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
                              Get.toNamed("/login/terms");
                            },
                          )
                        : SocialLoginButton(
                            text: "Google 계정으로 로그인",
                            color: ColorStyles.black,
                            backgroundColor: ColorStyles.white,
                            iconPath: "assets/icons/google.svg",
                            onPressed: () {
                              Get.toNamed("/login/terms");
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
