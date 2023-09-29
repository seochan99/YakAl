import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Survey/survey_model.dart';
import 'package:yakal/viewModels/Survey/survey_detail_bokyak_controller.dart';
import 'package:yakal/widgets/Survey/survey_header_widget.dart';
// Replace with the correct path

class SurveyDetailBokyakScreen extends StatelessWidget {
  final SurveyModel survey;
  final SurveyDetailBokyakController controller;

  SurveyDetailBokyakScreen({Key? key, required this.survey})
      : controller = Get.put(SurveyDetailBokyakController(surveyModel: survey)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          survey.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              /* ----------- Header ----------- */
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SurveyHeaderWidget(
                    content: survey.comment,
                    time: survey.time,
                    iconPath: survey.iconPath,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
              const SizedBox(height: 50),
              for (int i = 0; i < survey.questions.length; i++)
                QuestionWidget(
                  question: survey.questions[i].question,
                  options: survey.questions[i].options,
                  onOptionSelected: (int? optionIndex) {
                    controller.onOptionSelected(i, optionIndex!);
                  },
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GetBuilder<SurveyDetailBokyakController>(
                  builder: (controller) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        foregroundColor: Colors.white,
                        backgroundColor: controller.isCompletionEnabled()
                            ? const Color(0xff2666f6)
                            : const Color(0xffE9E9EE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: controller.isCompletionEnabled()
                          ? controller.handleButtonPress
                          : null,
                      child: const Text("완료", style: TextStyle(fontSize: 20.0)),
                    );
                  },
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

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
              textAlign: TextAlign.center, // Center-align the text

              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 22),
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
