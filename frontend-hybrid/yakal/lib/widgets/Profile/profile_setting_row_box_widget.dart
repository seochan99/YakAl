import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          if (routerLinkText == "/certification") {
            // WebView 페이지로 이동
            // Get.to(() => const WebviewWithWebviewFlutterScreen());
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
