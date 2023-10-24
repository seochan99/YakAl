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
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: "약 봉투로 약 추가하기"),
      ),
      body: SafeArea(
        child: Container(
          color: ColorStyles.gray1,
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
                      // full
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/ocr_preview.png",
                          width: MediaQuery.of(context).size.width,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 66,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
