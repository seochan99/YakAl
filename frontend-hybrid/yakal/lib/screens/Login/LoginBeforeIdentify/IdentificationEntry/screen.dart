import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/LoginBeforeIdentify/IdentificationEntry/style.dart';
import 'package:yakal/screens/Login/LoginBeforeIdentify/screen.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/bottom_button.dart';

class IdentificationEntryScreen extends StatelessWidget {
  static const routeName = "/identify/entry";

  final routeController = Get.put(LoginBeforeIdentifyController());

  IdentificationEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                child: BottomButton(
                  "건너뛰기",
                  onPressed: () {
                    routeController.goToInputNickName();
                  },
                  backgroundColor: ColorStyles.gray2,
                  color: ColorStyles.gray5,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: BottomButton(
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
    );
  }
}
