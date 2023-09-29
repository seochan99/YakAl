import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/style/color_styles.dart';

class TermsBackDialog extends StatelessWidget {
  const TermsBackDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorStyles.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SizedBox(
        height: 176,
        width: MediaQuery.of(context).size.width - 40.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text(
                "다시 로그인 하시겠습니까?",
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  height: 1.6,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: ColorStyles.gray2,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "아니요",
                          style: TextStyle(
                            color: ColorStyles.gray6,
                            fontFamily: "SUIT",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: ColorStyles.main,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "다시하기",
                          style: TextStyle(
                            color: ColorStyles.white,
                            fontFamily: "SUIT",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
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
    );
  }
}
