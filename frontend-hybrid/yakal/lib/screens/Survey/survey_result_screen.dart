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

    // comment 설정
    survey.setComment(survey.totalScore);

    // description 설정
    survey.setDescription();

    return Scaffold(
      appBar: AppBar(
        title: Text(survey.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(survey.resultComment),
            Text(survey.resultDescription),
          ],
        ),
      ),
    );
  }
}
