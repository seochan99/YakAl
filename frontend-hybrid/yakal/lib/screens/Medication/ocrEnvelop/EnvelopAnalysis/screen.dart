import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Medication/dose_list_view_model.dart';

class EnvelopAnalysisScreen extends StatefulWidget {
  const EnvelopAnalysisScreen({super.key});

  @override
  State<EnvelopAnalysisScreen> createState() => _EnvelopAnalysisScreenState();
}

class _EnvelopAnalysisScreenState extends State<EnvelopAnalysisScreen> {
  final doseListViewModel = Get.put(AddDoseViewModel());

  @override
  void initState() {
    super.initState();

    var imagePath = Get.arguments["imagePath"];

    if (kDebugMode) {
      print("🎑 [Received Image Path] $imagePath");
    }

    doseListViewModel.getMedicineInfoFromImagePath(imagePath).then((isSuccess) {
      File(imagePath).delete();

      if (isSuccess) {
        Get.offNamed(
          "/pill/add/final",
          preventDuplicates: false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('약 정보를 불러오는데 실패했습니다.'),
            duration: Duration(seconds: 3),
          ),
        );

        Get.offAllNamed("/");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gifSize = MediaQuery.of(context).size.width / 2;

    return Container(
      color: ColorStyles.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorStyles.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "약 정보 분석 중...",
                    style: TextStyle(
                      color: ColorStyles.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 1.685,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/data-processing.gif",
                    width: gifSize,
                    height: gifSize,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
