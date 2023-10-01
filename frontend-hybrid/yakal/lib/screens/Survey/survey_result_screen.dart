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
    SurveyModel survey = (Get.arguments as Map<dynamic, dynamic>)['survey'];
    UserViewModel userViewModel = Get.put(UserViewModel());

    // comment 설정
    survey.setComment(survey.totalScore);

    return Scaffold(
      appBar: AppBar(
        title: Text(survey.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff151515),
            )),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              SurveyResultHeader(userViewModel: userViewModel, survey: survey),
              Padding(
                // leading

                padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                child: Text(survey.resultDescription,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff151515),
                    )),
              ),
              const Spacer(),
              TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color(0xff2666F6),
                    foregroundColor: const Color(0xffffffff),
                  ),
                  onPressed: () {
                    Get.offAllNamed('/seniorSurvey');
                    // issue : bottomNavigation이 사라짐.. 고민 중...
                    // Get.back();
                    // Get.back();
                    // Popuntill

                    // 이러면 새로고침해야지 완료로 바뀜..고민중..
                  },
                  child: const Text(
                    "다른 테스트 하기",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  )),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SurveyResultHeader extends StatelessWidget {
  const SurveyResultHeader({
    super.key,
    required this.userViewModel,
    required this.survey,
  });

  final UserViewModel userViewModel;
  final SurveyModel survey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xffF1F5FE),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                fontSize: 20,
                color: Color(0xff151515),
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
