import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileSettingRowBtnWidget extends StatelessWidget {
  final String iconImg;
  final String text;
  final String routeLinkText;

  const ProfileSettingRowBtnWidget({
    required this.iconImg,
    required this.text,
    required this.routeLinkText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white, // Set the background color to white
      child: InkWell(
        onTap: () {
          Get.toNamed(routeLinkText);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                iconImg,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 16), // Add some space between icon and text
              Text(text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff151515),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
