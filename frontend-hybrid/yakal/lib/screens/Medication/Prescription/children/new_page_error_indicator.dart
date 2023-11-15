import 'package:flutter/material.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class NewPageErrorIndicator extends StatelessWidget {
  final void Function() onTryAgain;

  const NewPageErrorIndicator({
    super.key,
    required this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
      child: Column(
        children: [
          const Text(
            "다음 처방전을 불러오는데 실패했습니다.\n다시 시도하려면 탭하세요.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: ColorStyles.gray6,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            style: IconButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
            ),
            icon: const Icon(
              Icons.refresh,
              size: 18.0,
            ),
            color: ColorStyles.gray6,
            onPressed: onTryAgain,
          ),
        ],
      ),
    );
  }
}
