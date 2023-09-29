import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Survey/SurveyDetail/survey_detail_bokyak_screen.dart';

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
      ),
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
                TestList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Test {
  final Widget iconWidget;
  final String testName;
  final bool isCompleted;

  Test({
    required this.iconWidget,
    required this.testName,
    required this.isCompleted,
  });
}

class TestList extends StatelessWidget {
  const TestList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Test> tests = [
      Test(
        iconWidget: SvgPicture.asset(
          'assets/icons/circle_1.svg',
          width: 40,
          height: 40,
        ),
        testName: '복약 순응도 테스트',
        isCompleted: true,
      ),
      Test(
        iconWidget: SvgPicture.asset(
          'assets/icons/circle_2.svg',
          width: 40,
          height: 40,
        ),
        testName: '우울 척도 테스트',
        isCompleted: false,
      ),
      Test(
        iconWidget: SvgPicture.asset(
          'assets/icons/circle_2.svg',
          width: 40,
          height: 40,
        ),
        testName: '노쇠 테스트',
        isCompleted: false,
      ),
      Test(
        iconWidget: SvgPicture.asset(
          'assets/icons/circle_2.svg',
          width: 40,
          height: 40,
        ),
        testName: '간이 영양 상태 조사',
        isCompleted: false,
      ),
      Test(
        iconWidget: SvgPicture.asset(
          'assets/icons/circle_2.svg',
          width: 40,
          height: 40,
        ),
        testName: '일상생활 동작 지수',
        isCompleted: false,
      ),
      Test(
        iconWidget: SvgPicture.asset(
          'assets/icons/circle_3.svg',
          width: 40,
          height: 40,
        ),
        testName: '음주력 테스트',
        isCompleted: false,
      ),
      Test(
        iconWidget: SvgPicture.asset(
          'assets/icons/circle_4.svg',
          width: 40,
          height: 40,
        ),
        testName: '흡연력 테스트',
        isCompleted: false,
      ),
      Test(
        iconWidget: SvgPicture.asset(
          'assets/icons/circle_2.svg',
          width: 40,
          height: 40,
        ),
        testName: '시청각 테스트',
        isCompleted: false,
      ),
      Test(
        iconWidget: SvgPicture.asset(
          'assets/icons/circle_2.svg',
          width: 40,
          height: 40,
        ),
        testName: '치매 테스트',
        isCompleted: false,
      ),
      Test(
        iconWidget: SvgPicture.asset(
          'assets/icons/circle_2.svg',
          width: 40,
          height: 40,
        ),
        testName: '섬망 테스트',
        isCompleted: false,
      ),
      Test(
        iconWidget: SvgPicture.asset(
          'assets/icons/circle_5.svg',
          width: 40,
          height: 40,
        ),
        testName: '불면증 심각도 테스트',
        isCompleted: false,
      ),
      Test(
        iconWidget: SvgPicture.asset(
          'assets/icons/circle_2.svg',
          width: 40,
          height: 40,
        ),
        testName: '폐쇄성 수면 무호흡증',
        isCompleted: false,
      ),
      Test(
        iconWidget: SvgPicture.asset(
          'assets/icons/circle_6.svg',
          width: 40,
          height: 40,
        ),
        testName: '복용 중인 건강기능 식품',
        isCompleted: false,
      ),
      Test(
        iconWidget: SvgPicture.asset(
          'assets/icons/circle_2.svg',
          width: 40,
          height: 40,
        ),
        testName: '1년간 처방 받은 병의 진단명',
        isCompleted: false,
      ),
    ];

    int completedCount = tests.where((test) => test.isCompleted).length;

    return Column(
      children: [
        for (int index = 0; index < tests.length; index++)
          InkWell(
            onTap: () {
              if (!tests[index].isCompleted) {
                Get.to(() => SurveyDetailBokyakScreen());
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
                  tests[index].iconWidget,
                  const SizedBox(width: 12),
                  Text(
                    tests[index].testName,
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
