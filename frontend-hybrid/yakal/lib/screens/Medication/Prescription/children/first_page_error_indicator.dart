import 'package:flutter/material.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class FirstPageErrorIndicator extends StatelessWidget {
  final void Function() onTryAgain;

  const FirstPageErrorIndicator({
    super.key,
    required this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/failure.png",
            width: MediaQuery.of(context).size.width / 2,
          ),
          const SizedBox(
            height: 32,
          ),
          const Text(
            "처방전 목록을 불러오는데\n실패했습니다.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: ColorStyles.gray6,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              splashFactory: NoSplash.splashFactory,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor: ColorStyles.main,
            ),
            onPressed: onTryAgain,
            child: const Text(
              "다시 불러오기",
              style: TextStyle(
                fontSize: 16.0,
                color: ColorStyles.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
