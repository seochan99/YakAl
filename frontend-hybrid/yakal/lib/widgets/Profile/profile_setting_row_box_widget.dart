import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSettingRowBoxWidget extends StatelessWidget {
  final String text;
  final String? routerLinkText;

  const ProfileSettingRowBoxWidget({
    required this.text,
    required this.routerLinkText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white, // Set the background color to white
      child: InkWell(
        onTap: routerLinkText != null
            ? () {
                Get.toNamed(routerLinkText ?? "/profile");
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Row(
            children: [
              Text(text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff151515),
                  )),
              //  if text == "버전 정보" spacer, 버전 텍스트
              if (routerLinkText == null) const Spacer(),
              if (routerLinkText == null)
                const Text("1.0.0",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff90909F),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
