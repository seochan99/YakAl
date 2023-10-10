import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class EnvelopAnalysisScreen extends StatefulWidget {
  const EnvelopAnalysisScreen({super.key});

  @override
  State<EnvelopAnalysisScreen> createState() => _EnvelopAnalysisScreenState();
}

class _EnvelopAnalysisScreenState extends State<EnvelopAnalysisScreen> {
  @override
  void initState() {
    super.initState();

    // 임시!!!!!!!!!
    Timer(const Duration(seconds: 3), () {
      Get.offNamed("/pill/add/ocrEnvelop/result");
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
