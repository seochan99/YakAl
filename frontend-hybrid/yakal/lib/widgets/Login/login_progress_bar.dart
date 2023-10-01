import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utilities/enum/login_process.dart';
import '../../utilities/style/color_styles.dart';

class LoginAppBar extends StatelessWidget {
  final void Function() onPressed;
  final ELoginProcess progress;

  const LoginAppBar({
    super.key,
    required this.onPressed,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    /* Progress Bar Size Factor */
    const height = 8.0;
    final width = MediaQuery.of(context).size.width / 2.5;

    /* One Progress Segment Calculation */
    final progressElements = <Widget>[];
    for (var i = 0; i < ELoginProcess.values.length; ++i) {
      progressElements.add(
        Container(
          height: height,
          width: width / 6,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height),
            color: i <= progress.index ? ColorStyles.sub1 : ColorStyles.sub3,
          ),
        ),
      );
    }

    return AppBar(
      title: Container(
        height: height,
        width: width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: progressElements,
            ),
          ],
        ),
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
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
