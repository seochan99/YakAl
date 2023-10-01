import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SurveyDetailOption1BtnWidget extends StatelessWidget {
  final bool isSelected;
  final String option;

  const SurveyDetailOption1BtnWidget({
    super.key,
    required this.isSelected,
    required this.option,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          isSelected
              ? 'assets/icons/Check_active.svg'
              : 'assets/icons/Check_disable.svg',
          width: 48,
          height: 48,
        ),
        const SizedBox(height: 8),
        Text(
          option,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color:
                isSelected ? const Color(0xFF2666F6) : const Color(0xFF90909F),
          ),
        ),
      ],
    );
  }
}
