import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Medication/envelop_ocr_list_view_model.dart';
import 'package:yakal/widgets/Base/back_confirm_dialog.dart';
import 'package:yakal/widgets/Base/bottom_button.dart';
import 'package:yakal/widgets/Base/customized_back_app_bar.dart';
import 'package:yakal/widgets/Base/outer_frame.dart';

class EnvelopOcrAnalysisResult extends StatefulWidget {
  const EnvelopOcrAnalysisResult({super.key});

  @override
  State<EnvelopOcrAnalysisResult> createState() =>
      _EnvelopOcrAnalysisResultState();
}

class _EnvelopOcrAnalysisResultState extends State<EnvelopOcrAnalysisResult> {
  final envelopOcrListViewModel = Get.put(EnvelopOcrListViewModel());

  @override
  Widget build(BuildContext context) {
    return OuterFrame(
      outOfSafeAreaColor: ColorStyles.white,
      safeAreaColor: ColorStyles.white,
      appBar: CustomizedBackAppBar(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
            builder: (BuildContext context) {
              return const BackConfirmDialog(
                question: "사진을 다시 촬영하시겠습니까?",
                backTo: "/pill/add/ocrEnvelop",
              );
            },
          );
        },
        title: "약 추가하기",
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "AI가 분석한 정보가 올바른지\n확인해주세요.",
                  style: TextStyle(
                    color: ColorStyles.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "3일 복약",
                  style: TextStyle(
                    color: ColorStyles.gray5,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 20.0,
                    ),
                    splashFactory: NoSplash.splashFactory,
                    foregroundColor: ColorStyles.sub1,
                    backgroundColor: ColorStyles.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "기간/시간 수정",
                    style: TextStyle(
                      color: ColorStyles.main,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48,
            ),
            Expanded(
              child: Row(
                children: [
                  Obx(
                    () {
                      return ListView(
                        children: List.generate(
                          envelopOcrListViewModel.getGroupCount(),
                          (index) => ListView(
                            children: List.generate(
                              envelopOcrListViewModel
                                  .getItemCountOnGroup(index),
                              (index) => Text("!!"),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: BottomButton(
                    "완료",
                    onPressed: () {},
                    backgroundColor: ColorStyles.main,
                    color: ColorStyles.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
