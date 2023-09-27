import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileInfoIconBtnWidget extends StatelessWidget {
  final String goPage;
  final String iconImg;
  final String text;

  const ProfileInfoIconBtnWidget({
    Key? key,
    required this.iconImg,
    required this.text,
    required this.goPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(goPage); // Navigate to the specified page
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              iconImg,
              width: 60,
              height: 60,
            ),
            const SizedBox(
                height: 8.0), // Add some space between the icon and the text
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff151515),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
