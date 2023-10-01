import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utilities/enum/login_process.dart';
import '../../utilities/style/color_styles.dart';
import '../../widgets/Login/login_progress_bar.dart';

class AuthFinishScreen extends StatelessWidget {
  const AuthFinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorStyles.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorStyles.white,
          appBar: AppBar(
            title: LoginAppBar(
              progress: ELoginProcess.FINISHED,
              width: MediaQuery.of(context).size.width / 2.5,
              height: 8,
            ),
            backgroundColor: ColorStyles.white,
            automaticallyImplyLeading: true,
            leadingWidth: 90,
            leading: TextButton.icon(
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                foregroundColor: ColorStyles.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              icon: SvgPicture.asset("assets/icons/back.svg"),
              label: const Text(
                "뒤로",
                style: TextStyle(
                  color: ColorStyles.gray5,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "홍길동",
                                style: TextStyle(
                                  color: ColorStyles.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  height: 1.4,
                                ),
                              ),
                              Text(
                                "님,",
                                style: TextStyle(
                                  color: ColorStyles.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "회원가입이 완료되었습니다!",
                            style: TextStyle(
                              color: ColorStyles.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/logo.png",
                      width: MediaQuery.of(context).size.width * 0.55,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed("/");
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: ColorStyles.main,
                          splashFactory: NoSplash.splashFactory,
                          padding: const EdgeInsets.symmetric(
                            vertical: 18.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "메인으로",
                          style: TextStyle(
                            color: ColorStyles.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
