import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurveyResultController extends GetxController {
  final int totalScore;

  SurveyResultController(this.totalScore);

  // Your logic for the result screen using totalScore...
}

class SurveyResultScreen extends StatelessWidget {
  const SurveyResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Text('총 점수는 ${Get.arguments['totalScore']} '),
      ),
    );
  }
}
