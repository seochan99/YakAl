import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/ModeSelection/style.dart';
import 'package:yakal/utilities/enum/mode.dart';
import 'package:yakal/widgets/Login/login_frame.dart';
import 'package:yakal/widgets/Login/login_page_move_button.dart';
import 'package:yakal/widgets/Login/mode_selection_box.dart';

import '../../../utilities/enum/login_process.dart';
import '../../../utilities/style/color_styles.dart';
import '../../../widgets/Login/login_app_bar.dart';

class ModeSelectionScreen extends StatefulWidget {
  const ModeSelectionScreen({super.key});

  @override
  State<ModeSelectionScreen> createState() => _ModeSelectionScreenState();
}

class _ModeSelectionScreenState extends State<ModeSelectionScreen> {
  EMode _mode = EMode.NONE;

  @override
  Widget build(BuildContext context) {
    return LoginFrame(
      outOfSafeAreaColor: ColorStyles.white,
      safeAreaColor: ColorStyles.white,
      appBar: LoginAppBar(
        progress: ELoginProcess.SELECT_MODE,
        onPressed: () {
          Get.back();
        },
      ),
      child: Padding(
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
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              height: 1.4,
                            ),
                          ),
                          Text(
                            "를 선택해주세요",
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
                              child: ModeSelectionBox(
                                backgroundColor: _mode == EMode.NORMAL
                                    ? ColorStyles.sub3
                                    : ColorStyles.white,
                                borderColor: _mode == EMode.NORMAL
                                    ? ColorStyles.sub1
                                    : ColorStyles.gray2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "일반모드",
                                      style: _mode == EMode.NORMAL
                                          ? ModeSelectionStyle.selectedModeTitle
                                          : ModeSelectionStyle.modeTitle,
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    Text(
                                      "약알의 일반적인 모드입니다.",
                                      style: _mode == EMode.NORMAL
                                          ? ModeSelectionStyle
                                              .selectedModeDescription
                                          : ModeSelectionStyle.modeDescription,
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
                              child: ModeSelectionBox(
                                backgroundColor: _mode == EMode.LITE
                                    ? ColorStyles.sub3
                                    : ColorStyles.white,
                                borderColor: _mode == EMode.LITE
                                    ? ColorStyles.sub1
                                    : ColorStyles.gray2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "라이트 모드",
                                      style: _mode == EMode.LITE
                                          ? ModeSelectionStyle.selectedModeTitle
                                          : ModeSelectionStyle.modeTitle,
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "시니어를 위한 쉬운 모드",
                                          style: _mode == EMode.LITE
                                              ? ModeSelectionStyle
                                                  .selectedBoldModeDescription
                                              : ModeSelectionStyle
                                                  .boldModeDescription,
                                        ),
                                        Text(
                                          "입니다.",
                                          style: _mode == EMode.LITE
                                              ? ModeSelectionStyle
                                                  .selectedModeDescription
                                              : ModeSelectionStyle
                                                  .modeDescription,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "다제약물 정보가 포함되어 있습니다.",
                                      style: _mode == EMode.LITE
                                          ? ModeSelectionStyle
                                              .selectedModeDescription
                                          : ModeSelectionStyle.modeDescription,
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
                  child: _mode == EMode.NONE
                      ? const LoginPageMoveButton(
                          "다음",
                          onPressed: null,
                          backgroundColor: ColorStyles.gray2,
                          color: ColorStyles.gray3,
                        )
                      : LoginPageMoveButton(
                          "다음",
                          onPressed: () {
                            Get.toNamed("/login/mode/process",
                                arguments: _mode.index);
                          },
                          backgroundColor: ColorStyles.main,
                          color: ColorStyles.white,
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
