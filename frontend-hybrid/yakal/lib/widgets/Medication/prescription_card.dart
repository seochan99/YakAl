import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class PrescriptionCard extends StatelessWidget {
  final int id;

  const PrescriptionCard({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (kDebugMode) {
          print("Selected Prescription Id: $id");
        }
        Get.toNamed("/pill/manage/dose", arguments: {"id": id});
      },
      child: Container(
        height: 40.0,
        width: MediaQuery.of(context).size.width - 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: ColorStyles.gray2,
        ),
        child: Center(
          child: Text(
            id.toString(),
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: ColorStyles.black,
            ),
          ),
        ),
      ),
    );
  }
}
