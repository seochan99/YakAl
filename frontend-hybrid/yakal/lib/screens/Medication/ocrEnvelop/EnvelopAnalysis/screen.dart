import 'dart:async';

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
  final doseListViewModel = Get.put(DoseListViewModel());

  @override
  void initState() {
    super.initState();

    // 임시!!!!!!!!!
    Timer(const Duration(seconds: 3), () {
      doseListViewModel.setGroupList([
        {
          "name": "올메텍플러스정20/12.5mg",
          "code": "ESNKSTB0KA1",
        },
        {
          "name": "바난정",
          "code": "ECJDSTB01V4",
        },
        {
          "name": "레보프라이드정",
          "code": "ESKPSTB003H",
        },
        {
          "name": "싸이메트정",
          "code": "EBKWSTB001O",
        },
        {
          "name": "비졸본정",
          "code": "OSAKSTBCJRI",
        },
        {
          "name": "한미아스피린장용정100mg",
          "code": "OHMISTE0AA9",
        },
      ]);

      Get.offNamed(
        "/pill/add/final",
        preventDuplicates: false,
      );
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
