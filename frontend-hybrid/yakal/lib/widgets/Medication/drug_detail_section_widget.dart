import 'package:flutter/material.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Medication/drug_detail_widget.dart';

class DurgDetailSection extends StatelessWidget {
  final String imageName;
  final String title;
  final String? detail;

  const DurgDetailSection({
    Key? key,
    required this.imageName,
    required this.title,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrugDetailWidget(
            imageName: imageName,
            text: title,
          ),
          const SizedBox(height: 10),
          Text(
            (detail == null || detail!.isEmpty)
                ? "준비 중 입니다!"
                : detail!.split('<br>').join('\n'),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: ColorStyles.gray6,
            ),
          )
        ],
      ),
    );
  }
}
