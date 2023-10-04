import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class InfoAddBtnWidget extends StatelessWidget {
  final String content;
  final VoidCallback actionSheet;

  const InfoAddBtnWidget(
      {super.key, required this.actionSheet, required this.content});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: ColorStyles.gray1,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: actionSheet,
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/plus-circle.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 14),
            Text(
              content,
              style: const TextStyle(
                  color: ColorStyles.gray5,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ));
  }
}
