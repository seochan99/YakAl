import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Survey/survey_model.dart';

class SurveyResultController extends GetxController {
  final int totalScore;

  SurveyResultController(this.totalScore);
}

class SurveyResultScreen extends StatelessWidget {
  const SurveyResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SurveyModel survey = (Get.arguments as Map<String, dynamic>)['survey'];

    return Scaffold(
      appBar: AppBar(
        title: Text(survey.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(survey.totalScore.toString()),
            Text(survey.resultComment),
          ],
        ),
      ),
    );
  }
}
