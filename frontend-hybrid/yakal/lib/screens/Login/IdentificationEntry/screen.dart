import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/IdentificationEntry/style.dart';
import 'package:yakal/widgets/Login/login_frame.dart';
import 'package:yakal/widgets/Login/login_page_move_button.dart';

import '../../../utilities/enum/login_process.dart';
import '../../../utilities/style/color_styles.dart';
import '../../../widgets/Login/back_confirm_dialog.dart';
import '../../../widgets/Login/login_app_bar.dart';

class IdentificationEntryScreen extends StatelessWidget {
  const IdentificationEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginFrame(
      outOfSafeAreaColor: ColorStyles.white,
      safeAreaColor: ColorStyles.white,
      appBar: LoginAppBar(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
            builder: (BuildContext context) {
              return const BackConfirmDialog(
                question: "로그인을 다시 시도하시겠습니까?",
                backTo: "/login",
              );
            },
          );
        },
        progress: ELoginProcess.IDENTIFY,
      ),
      child: Padding(
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
                      style: IdentificationEntryStyle.boldTitle,
                    ),
                    Text(
                      "을 해주세요",
                      style: IdentificationEntryStyle.title,
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
                        style: IdentificationEntryStyle.description,
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
                  child: LoginPageMoveButton(
                    "건너뛰기",
                    onPressed: () {
                      Get.toNamed("/login/nickname");
                    },
                    backgroundColor: ColorStyles.gray2,
                    color: ColorStyles.gray5,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: LoginPageMoveButton(
                    "인증하기",
                    onPressed: () {
                      Get.toNamed("/login/identify/process");
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
