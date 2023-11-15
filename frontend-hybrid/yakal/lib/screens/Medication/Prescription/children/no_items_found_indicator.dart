import 'package:flutter/material.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class NoItemsFoundIndicator extends StatelessWidget {
  const NoItemsFoundIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/not-found-icon.png",
            width: MediaQuery.of(context).size.width / 2,
          ),
          const SizedBox(
            height: 32,
          ),
          const Text(
            "아직 만들어진 처방전이 없습니다.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: ColorStyles.gray6,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
