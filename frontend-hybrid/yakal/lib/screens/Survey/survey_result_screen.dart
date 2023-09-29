import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Survey/survey_model.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';

class SurveyResultController extends GetxController {
  final int totalScore;

  SurveyResultController(this.totalScore);
}

class SurveyResultScreen extends StatelessWidget {
  const SurveyResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SurveyModel survey = (Get.arguments as Map<String, dynamic>)['survey'];
    UserViewModel userViewModel = Get.put(UserViewModel());
    // comment 설정
    survey.setComment(survey.totalScore);

    // description 설정
    survey.setDescription();

    return Scaffold(
      appBar: AppBar(
        title: Text(survey.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff151515),
            )),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: const Color(0xffF1F5FE),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${userViewModel.user.value.nickName}님의\n${survey.title} 결과는',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff464655),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        survey.resultComment,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff151515),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ]),
              ),
            ),
            Text(survey.resultDescription),
          ],
        ),
      ),
    );
  }
}
