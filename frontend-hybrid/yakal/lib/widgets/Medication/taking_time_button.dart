import 'package:flutter/material.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class TakingTimeButton extends StatelessWidget {
  final void Function() onChanged;
  final bool isTaking;
  final ETakingTime takingTime;

  const TakingTimeButton({
    super.key,
    required this.onChanged,
    required this.isTaking,
    required this.takingTime,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        splashFactory: NoSplash.splashFactory,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
        shape: RoundedRectangleBorder(
          side: isTaking
              ? const BorderSide(
                  color: ColorStyles.main,
                )
              : BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: isTaking ? ColorStyles.sub3 : ColorStyles.gray1,
      ),
      onPressed: onChanged,
      child: Text(
        takingTime.time,
        style: TextStyle(
          color: isTaking ? ColorStyles.main : ColorStyles.gray3,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
    );
  }
}
