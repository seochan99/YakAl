import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class DefaultBackAppbar extends StatelessWidget {
  final String title;
  const DefaultBackAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      backgroundColor: ColorStyles.white,
      automaticallyImplyLeading: true,
      leadingWidth: 90,
      leading: TextButton.icon(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          foregroundColor: ColorStyles.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        icon: SvgPicture.asset("assets/icons/back.svg"),
        label: const Text(
          "뒤로",
          style: TextStyle(
            color: ColorStyles.gray5,
            fontFamily: "SUIT",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}
