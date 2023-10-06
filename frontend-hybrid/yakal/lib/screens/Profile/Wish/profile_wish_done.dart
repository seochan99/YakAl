import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

class ProfileWishDoneScreen extends StatelessWidget {
  const ProfileWishDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: DefaultBackAppbar(
            title: "약알에게 바라는 점",
          ),
        ),
        body: Center(
          child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '감사합니다!\n의견이 잘 전달되었습니다:)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF151515),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 48),
                  // 홈으로 이동 버튼
                  TextButton(
                    onPressed: () {
                      Get.offAndToNamed("/");
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 15),
                      backgroundColor: ColorStyles.main,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      '내 정보로 이동',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}
