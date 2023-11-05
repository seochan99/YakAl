import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class ProfileSettingRowBoxWidget extends StatelessWidget {
  final String text;
  final String? routerLinkText;

  const ProfileSettingRowBoxWidget({
    required this.text,
    required this.routerLinkText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          if (routerLinkText == null) return;
          if (routerLinkText == "/certification") {
            // copy link
            Clipboard.setData(const ClipboardData(
                    text: 'https://yakal.dcs-hyungjoon.com/'))
                .then((_) {
              Get.snackbar(
                '전문가 인증 링크 복사',
                '복사된 링크를 통해 웹에서 전문가 인증을 진행해주세요!',
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                duration: const Duration(seconds: 1, microseconds: 500),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: ColorStyles.gray1,
                colorText: Colors.black,
              );
            });
          } else {
            // 다른 페이지로 이동
            Get.toNamed(routerLinkText ?? "/profile");
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Row(
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff151515),
                ),
              ),
              if (routerLinkText == null) const Spacer(),
              if (routerLinkText == null)
                const Text(
                  "1.0.0",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff90909F),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
