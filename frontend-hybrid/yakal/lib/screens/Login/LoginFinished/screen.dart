import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/LoginFinished/style.dart';
import 'package:yakal/widgets/Login/login_frame.dart';
import 'package:yakal/widgets/Login/login_page_move_button.dart';

import '../../../utilities/enum/login_process.dart';
import '../../../utilities/style/color_styles.dart';
import '../../../widgets/Login/login_progress_bar.dart';

class LoginFinishedScreen extends StatelessWidget {
  const LoginFinishedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginFrame(
      outOfSafeAreaColor: ColorStyles.white,
      safeAreaColor: ColorStyles.white,
      appBar: LoginAppBar(
        progress: ELoginProcess.FINISHED,
        onPressed: () {
          Get.back();
        },
      ) as AppBar,
      child: Padding(
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
                            style: LoginFinishedStyle.name,
                          ),
                          Text(
                            "님,",
                            style: LoginFinishedStyle.title,
                          ),
                        ],
                      ),
                      Text(
                        "회원가입이 완료되었습니다!",
                        style: LoginFinishedStyle.title,
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
                  child: LoginPageMoveButton(
                    "메인으로",
                    onPressed: () {
                      Get.toNamed("/");
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
