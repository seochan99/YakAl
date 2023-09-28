import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:yakal/widgets/Survey/survey_header_widget.dart';

import 'package:flutter/material.dart';

class SurveyDetailBokyakScreen extends StatefulWidget {
  const SurveyDetailBokyakScreen({Key? key}) : super(key: key);

  @override
  _SurveyDetailBokyakScreenState createState() =>
      _SurveyDetailBokyakScreenState();
}

class _SurveyDetailBokyakScreenState extends State<SurveyDetailBokyakScreen> {
  List<String?> selectedOptions = List.filled(12, null);

  void onOptionSelected(int questionIndex, int optionIndex) {
    setState(() {
      selectedOptions[questionIndex] = options[optionIndex];
    });
  }

  int calculateTotalScore() {
    int totalScore = 0;

    for (String? option in selectedOptions) {
      if (option == options[0]) {
        totalScore += 1;
      } else if (option == options[1]) {
        totalScore += 2;
      } else if (option == options[2]) {
        totalScore += 3;
      } else if (option == options[3]) {
        totalScore += 4;
      }
    }

    return totalScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '복약 순응도 테스트',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              /* ----------- Header ----------- */
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SurveyHeaderWidget(
                    content:
                        '약알 이용자의 복약 습관과 복약 순응도를\n파악하여 의약품 복용에 \n도움을 드리기 위한 설문입니다.\n',
                    time: '3',
                    iconPath: 'assets/icons/circle_1.svg',
                  ),
                  SizedBox(height: 16),
                ],
              ),
              const SizedBox(height: 50),
              for (int i = 0; i < questions.length; i++)
                QuestionWidget(
                  question: questions[i],
                  options: options,
                  onOptionSelected: (int? optionIndex) {
                    onOptionSelected(i, optionIndex!);
                  },
                ),
              ElevatedButton(
                onPressed: () {
                  int totalScore = calculateTotalScore();
                  print('Total Score: $totalScore');
                },
                child: const Text('Calculate Total Score'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const List<String> questions = [
  "얼마나 자주 약 복용하는 것을 잊어버리십니까?",
  "얼마나 자주 약을 복용하지 않겠다고 결정하십니까?",
  "얼마나 자주 약 받는 것을 잊어버리십니까?",
  "얼마나 자주 약이 다 떨어집니까?",
  "의사에게 가기 전에 얼마나 자주 약 복용하는 것을 건너 뛰십니까?",
  "몸이 나아졌다고 느낄 때 얼마나 자주 약 복용하는 것을 빠뜨리십니까?",
  "몸이 아프다고 느낄 때 얼마나 자주 약 복용을 빠뜨리십니까?",
  "얼마나 자주 본인의 부주의로 약 복용하는 것을 빠뜨리십니까?",
  "얼마나 자주 본인의 필요에 따라 약 용량을 바꾸십니까? (원래 복용하셔야 하는 것보다 더 많게 혹은 더 적게 복용하시는 것)",
  "하루 한번이상 약을 복용해야 할 때 얼마나 자주 약 복용 하는 것을 잊어버리십니까?",
  "얼마나 자주 약값이 비싸서 다시 약 처방 받는 것을 미루십니까?",
  "약이 떨어지기 전에 얼마나 자주 미리 계획하여 약 처방을 다시 받습니까?"
];

const List<String> options = ['전혀없음', '가끔', '대부분', '항상'];

class QuestionWidget extends StatefulWidget {
  final String question;
  final List<String> options;
  final Function(int?) onOptionSelected;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int? selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              widget.question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.options.asMap().entries.map((entry) {
              int index = entry.key;
              String option = entry.value;
              bool isSelected = selectedOptionIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOptionIndex = index;
                    widget.onOptionSelected(index);
                  });
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      isSelected
                          ? 'assets/icons/Check_active.svg'
                          : 'assets/icons/Check_disable.svg',
                      width: 48,
                      height: 48,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      option,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? const Color(0xFF2666F6)
                            : const Color(0xFF90909F),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Container(
              width: double.infinity,
              color: const Color(0xffE9E9EE),
              height: 1,
            ),
          )
        ],
      ),
    );
  }
}
