import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Survey/survey_model.dart';
import 'package:yakal/screens/Survey/SurveyDetail/survey_detail_screen.dart';

class SurveySeniorScreen extends StatelessWidget {
  const SurveySeniorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            '자가 진단 테스트 (65세 이상)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            icon: const Icon(Icons.chevron_left,
                size: 32, color: Color(0xff151515)),
            onPressed: () {
              // Get.back();
              Get.toNamed('/');
            },
          )),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '하나씩 완료해보세요!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 16),
                Text(
                  '테스트를 완료할수록 \n나에게 더 알맞는 맞춤형 진료를 받으실 수 있습니다.\n',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                SurveSenioryList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SurveSenioryList extends StatelessWidget {
  const SurveSenioryList({super.key});

  @override
  Widget build(BuildContext context) {
    int completedCount = tests.where((test) => test.isCompleted).length;

    return Column(
      children: [
        for (int index = 0; index < tests.length; index++)
          if (tests[index].isSenior == 0 || tests[index].isSenior == 2)
            InkWell(
              onTap: () {
                // test type별로 별도 view구성 처리하기
                if (!tests[index].isCompleted) {
                  Get.to(() => SurveyDetailType1Screen(
                        survey: tests[index],
                      ));
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: tests[index].isCompleted
                      ? const Color(0xFFF5F5F9)
                      : const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: tests[index].isCompleted
                        ? const Color(0xFFF5F5F9)
                        : const Color(0xFFE9E9EE),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      tests[index].iconPath,
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      tests[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        color: tests[index].isCompleted
                            ? const Color(0xffC6C6CF)
                            : const Color(0xff151515),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      tests[index].isCompleted ? '완료' : '미완료',
                      style: TextStyle(
                        fontSize: 16,
                        color: tests[index].isCompleted
                            ? const Color(0xffC6C6CF)
                            : const Color(0xff5588FD),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        const SizedBox(height: 16),
      ],
    );
  }
}
