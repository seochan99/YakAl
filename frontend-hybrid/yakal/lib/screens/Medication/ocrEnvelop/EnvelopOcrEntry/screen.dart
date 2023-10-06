import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Medication/ocrEnvelop/EnvelopOcrEntry/style.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

import '../../../../utilities/style/color_styles.dart';
import '../../../../widgets/Base/bottom_button.dart';

class EnvelopOcrEntryScreen extends StatelessWidget {
  const EnvelopOcrEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = 30.0;
    final previewScale =
        (MediaQuery.of(context).size.width - padding * 2.0) / 340.0;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: "약 봉투로 약 추가하기"),
      ),
      body: SafeArea(
        child: Container(
          color: ColorStyles.gray1,
          child: Padding(
            padding: const EdgeInsets.all(padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "이렇게 촬영해주세요!",
                            style: EnvelopOcrEntryStyle.title,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Transform.scale(
                                scale: previewScale,
                                child: SvgPicture.asset(
                                  "assets/images/phone-outline.svg",
                                ),
                              ),
                              Transform.translate(
                                offset:
                                    Offset(300 * (1 + previewScale) / 2, 78.07),
                                child: Transform.scale(
                                  scale: previewScale,
                                  child: SvgPicture.asset(
                                    "assets/images/bottom-button.svg",
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(
                                    17.7 * previewScale +
                                        340 * (1 - previewScale) / 2,
                                    75.74),
                                child: Transform.scale(
                                  scale: previewScale,
                                  child: SvgPicture.asset(
                                    "assets/images/speaker.svg",
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(41.09, 10.13),
                                child: Transform.scale(
                                  scale: previewScale,
                                  child: SvgPicture.asset(
                                    "assets/images/screen.svg",
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(53.64, 12.8),
                                child: Transform.scale(
                                  scale: previewScale,
                                  child: SvgPicture.asset(
                                    "assets/images/medicine-envelop.svg",
                                    colorFilter: const ColorFilter.mode(
                                      ColorStyles.white,
                                      BlendMode.dstOver,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 66,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/num-1.svg",
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text(
                            "평평한 곳에 약 봉투를 놓아주세요.",
                            style: EnvelopOcrEntryStyle.description,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/num-2.svg",
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text(
                            "휴대폰의 가로화면 영역 안에 약 봉투가\n꽉 차도록 조절하여 촬영해주세요.",
                            style: EnvelopOcrEntryStyle.description,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: BottomButton(
                        "촬영하기",
                        onPressed: () {
                          Get.toNamed("/pill/add/ocrEnvelop/shot");
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
        ),
      ),
    );
  }
}
