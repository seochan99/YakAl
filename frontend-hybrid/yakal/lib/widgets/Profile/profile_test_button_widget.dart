import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileTestButtonWidget extends StatelessWidget {
  final String boldText;
  final String normalText;
  final Color btnColor;

  const ProfileTestButtonWidget(
      {Key? key,
      required this.boldText,
      required this.normalText,
      required this.btnColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        // padding 20
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: btnColor,
          // border none
        ),
        onPressed: () {
          // senior normal
          if (boldText == "시니어") {
            Get.toNamed("/seniorSurvey");
          } else {
            Get.toNamed("/normalSurvey");
          }
        },
        // rich text 일반만 bold체
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: boldText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                )),
            TextSpan(
                text: normalText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                )),
          ]),
        ));
  }
}
