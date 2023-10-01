import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utilities/enum/login_process.dart';
import '../../utilities/style/color_styles.dart';
import '../../widgets/Login/login_progress_bar.dart';

class IdentificationEntryScreen extends StatelessWidget {
  const IdentificationEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorStyles.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorStyles.white,
          appBar: AppBar(
            title: LoginAppBar(
              progress: ELoginProcess.IDENTIFY,
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
                Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          "본인인증",
                          style: TextStyle(
                            color: ColorStyles.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          "을 해주세요",
                          style: TextStyle(
                            color: ColorStyles.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: const Text(
                            """보호자가 아닌 반드시 본인명의로 인증해야\n안전한 약알을 이용하실 수 있어요 :)""",
                            style: TextStyle(
                              color: ColorStyles.gray5,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.6,
                            ),
                          ),
                        )
                      ],
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed("/login/nickname");
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: ColorStyles.gray2,
                          splashFactory: NoSplash.splashFactory,
                          padding: const EdgeInsets.symmetric(
                            vertical: 18.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "건너뛰기",
                          style: TextStyle(
                            color: ColorStyles.gray5,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed("/login/identify/process");
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
                          "인증하기",
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
