import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/enum/mode.dart';

import '../../utilities/enum/login_process.dart';
import '../../utilities/style/color_styles.dart';
import '../../widgets/Auth/login_progress_bar.dart';

class SelectModeScreen extends StatefulWidget {
  const SelectModeScreen({super.key});

  @override
  State<SelectModeScreen> createState() => _SelectModeScreenState();
}

class _SelectModeScreenState extends State<SelectModeScreen> {
  EMode _mode = EMode.NONE;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorStyles.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorStyles.white,
          appBar: AppBar(
            title: LoginProgressBar(
              progress: ELoginProcess.SELECT_MODE,
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
                  fontFamily: "SUIT",
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                "모드",
                                style: TextStyle(
                                  color: ColorStyles.black,
                                  fontFamily: "SUIT",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  height: 1.4,
                                ),
                              ),
                              Text(
                                "를 선택해주세요",
                                style: TextStyle(
                                  color: ColorStyles.black,
                                  fontFamily: "SUIT",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 42.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _mode = EMode.NORMAL;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 24.0,
                                      horizontal: 20.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _mode == EMode.NORMAL
                                          ? ColorStyles.sub3
                                          : ColorStyles.white,
                                      border: Border.all(
                                        color: _mode == EMode.NORMAL
                                            ? ColorStyles.sub1
                                            : ColorStyles.gray2,
                                        width: 2.0,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "일반모드",
                                          style: TextStyle(
                                            color: ColorStyles.gray6,
                                            fontFamily: "SUIT",
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            height: 1,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16.0,
                                        ),
                                        Text(
                                          "약알의 일반적인 모드입니다.",
                                          style: TextStyle(
                                            color: ColorStyles.gray6,
                                            fontFamily: "SUIT",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _mode = EMode.LITE;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 24.0,
                                      horizontal: 20.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _mode == EMode.LITE
                                          ? ColorStyles.sub3
                                          : ColorStyles.white,
                                      border: Border.all(
                                        color: _mode == EMode.LITE
                                            ? ColorStyles.sub1
                                            : ColorStyles.gray2,
                                        width: 2.0,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "라이트 모드",
                                          style: TextStyle(
                                            color: ColorStyles.gray6,
                                            fontFamily: "SUIT",
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            height: 1,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16.0,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "시니어를 위한 쉬운 모드",
                                              style: TextStyle(
                                                color: ColorStyles.gray6,
                                                fontFamily: "SUIT",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                height: 1.6,
                                              ),
                                            ),
                                            Text(
                                              "입니다.",
                                              style: TextStyle(
                                                color: ColorStyles.gray6,
                                                fontFamily: "SUIT",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                height: 1.6,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "다제약물 정보가 포함되어 있습니다.",
                                          style: TextStyle(
                                            color: ColorStyles.gray6,
                                            fontFamily: "SUIT",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            height: 1.6,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed("/login/finish");
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: _mode == EMode.NONE
                              ? ColorStyles.gray2
                              : ColorStyles.main,
                          splashFactory: NoSplash.splashFactory,
                          padding: const EdgeInsets.symmetric(
                            vertical: 18.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          "다음",
                          style: TextStyle(
                            color: _mode == EMode.NONE
                                ? ColorStyles.gray3
                                : ColorStyles.white,
                            fontFamily: "SUIT",
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
