import 'package:flutter/material.dart';

class SurveyDetailOption3BtnWidget extends StatelessWidget {
  final bool isSelected;
  final String option;

  const SurveyDetailOption3BtnWidget({
    super.key,
    required this.isSelected,
    required this.option,
  });

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width / 2.5;

    final backgroundColor =
        isSelected ? const Color(0xFFF1F5FE) : const Color(0xFFFFFFFF);
    final borderColor =
        isSelected ? const Color(0xFF5588FD) : const Color(0xFFE9E9EE);
    return Container(
      width: containerWidth,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        option,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: isSelected ? const Color(0xFF2666F6) : const Color(0xFF626272),
        ),
      ),
    );
  }
}
