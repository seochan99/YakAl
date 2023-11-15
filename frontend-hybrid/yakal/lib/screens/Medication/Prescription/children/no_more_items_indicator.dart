import 'package:flutter/material.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class NoMoreItemsIndicator extends StatelessWidget {
  const NoMoreItemsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
      child: Column(
        children: [
          Text(
            "더 이상 처방전이 없습니다.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: ColorStyles.gray6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
