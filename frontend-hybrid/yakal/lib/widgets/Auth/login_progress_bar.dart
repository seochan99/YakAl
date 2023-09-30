import 'package:flutter/material.dart';

import '../../utilities/enum/login_process.dart';
import '../../utilities/style/color_styles.dart';

class LoginProgressBar extends StatelessWidget {
  final ELoginProcess progress;
  final double height;
  final double width;

  const LoginProgressBar({
    super.key,
    this.height = 4,
    this.width = 120,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final progressElements = <Widget>[];
    for (var i = 0; i < ELoginProcess.values.length; ++i) {
      progressElements.add(
        Container(
          height: height,
          width: width / 5,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height),
            color: i <= progress.index ? ColorStyles.sub1 : ColorStyles.sub3,
          ),
        ),
      );
    }

    return Container(
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
    );
  }
}
