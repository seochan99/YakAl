import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class DrugDetailWidget extends StatelessWidget {
  final String imageName;
  final String text;

  const DrugDetailWidget(
      {super.key, required this.imageName, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          imageName,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorStyles.black),
          ),
        ),
      ],
    );
  }
}
