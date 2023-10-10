import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Medication/envelop_ocr_list_view_model.dart';
import 'package:yakal/widgets/Base/back_confirm_dialog.dart';
import 'package:yakal/widgets/Base/bottom_button.dart';
import 'package:yakal/widgets/Base/customized_back_app_bar.dart';
import 'package:yakal/widgets/Base/outer_frame.dart';
import 'package:yakal/widgets/Medication/dose_add_calendar.dart';
import 'package:yakal/widgets/Medication/taking_time_button.dart';

class MedicationDirectResult extends StatefulWidget {
  const MedicationDirectResult({super.key});

  @override
  State<MedicationDirectResult> createState() => _MedicationDirectResultState();
}

class _MedicationDirectResultState extends State<MedicationDirectResult> {
  final envelopOcrListViewModel = Get.put(EnvelopOcrListViewModel());

// arguemnts code가져오기
  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments;
    if (arguments != null) {
      final code = arguments["code"];
      final name = arguments["name"];
      print(code);
      print(name);
    }
  }

  bool _isModificationMode = false;

  void _switchMode() {
    setState(() {
      _isModificationMode = !_isModificationMode;
    });
  }

  Widget _getListView() {
    return ListView.separated(
      itemCount: envelopOcrListViewModel.getGroupCount(),
      itemBuilder: (context, groupIndex) {
        final group = envelopOcrListViewModel.getGroupList()[groupIndex];

        final totalTimeList = ETakingTime.values.sublist(0, 4);

        String groupTime = "";
        for (var takingTime in totalTimeList) {
          if (group.takingTime[takingTime.index] == true) {
            groupTime = "$groupTime, ${takingTime.time}";
          }
        }
        groupTime = groupTime.substring(", ".length);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              groupTime,
              style: const TextStyle(
                color: ColorStyles.gray5,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  envelopOcrListViewModel.getItemCountOnGroup(groupIndex),
              itemBuilder: (context, itemIndex) => Column(
                children: [
                  Row(
                    children: [
                      group.doseList[itemIndex].base64Image != null
                          ? Image.memory(
                              base64Decode(
                                group.doseList[itemIndex].base64Image!,
                              ),
                            )
                          : Container(
                              width: 64,
                              height: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: ColorStyles.gray2,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.question_mark_outlined,
                                  size: 18,
                                  color: ColorStyles.gray3,
                                ),
                              ),
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        group.doseList[itemIndex].name,
                        style: const TextStyle(
                          color: ColorStyles.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 48,
      ),
    );
  }

  Widget _getModificationView() {
    var groupList = envelopOcrListViewModel.getGroupList();
    var modificationList = [];

    var groupIndex = 0;
    var itemIndex = 0;

    for (var groupItem in groupList) {
      for (var doseItem in groupItem.doseList) {
        modificationList.add({
          "item": doseItem,
          "groupIndex": groupIndex,
          "itemIndex": itemIndex,
          "takingTime": groupItem.takingTime.toList(),
        });
        ++itemIndex;
      }
      ++groupIndex;
      itemIndex = 0;
    }

    modificationList.sort((e1, e2) =>
        (e1["item"].name as String).compareTo(e2["item"].name as String));

    return ListView.separated(
      itemCount: modificationList.length,
      itemBuilder: (context, index) {
        var modificationElement = modificationList[index];
        return Column(
          children: [
            Row(
              children: [
                modificationElement["item"].base64Image != null
                    ? Image.memory(
                        base64Decode(
                          modificationElement["item"].base64Image!,
                        ),
                      )
                    : Container(
                        width: 64,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: ColorStyles.gray2,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.question_mark_outlined,
                            size: 18,
                            color: ColorStyles.gray3,
                          ),
                        ),
                      ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  modificationElement["item"].name,
                  style: const TextStyle(
                    color: ColorStyles.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: List.generate(
                ETakingTime.values.sublist(0, 4).length,
                (index) {
                  return Row(
                    children: [
                      TakingTimeButton(
                        onChanged: () {
                          envelopOcrListViewModel.toggle(
                            modificationElement["groupIndex"],
                            modificationElement["itemIndex"],
                            ETakingTime.values[index],
                            !modificationElement["takingTime"][index],
                          );
                        },
                        isTaking: modificationElement["takingTime"][index],
                        takingTime: ETakingTime.values[index],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 24,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoseAddCalenderController());

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
                if (_isModificationMode)
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 10.0,
                      ),
                      splashFactory: NoSplash.splashFactory,
                      foregroundColor: ColorStyles.gray4,
                      backgroundColor: ColorStyles.gray1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        barrierColor: const Color.fromRGBO(98, 98, 114, 0.20),
                        builder: (context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(30.0),
                            decoration: const BoxDecoration(
                              color: ColorStyles.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Column(
                              children: [
                                const DoseAddCalendar(),
                                const SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: BottomButton(
                                        "완료",
                                        onPressed: () {
                                          Get.back();
                                        },
                                        backgroundColor: ColorStyles.main,
                                        color: ColorStyles.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Obx(
                      () {
                        var duration = controller.getDuration();
                        return Text(
                          duration == 0 ? "기간을 정해야 합니다." : "$duration일 복약",
                          style: const TextStyle(
                            color: ColorStyles.gray5,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        );
                      },
                    ),
                  )
                else
                  Obx(
                    () {
                      var duration = controller.getDuration();
                      return Text(
                        duration == 0 ? "기간을 정해야 합니다." : "$duration일 복약",
                        style: const TextStyle(
                          color: ColorStyles.gray5,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      );
                    },
                  ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 10.0,
                    ),
                    splashFactory: NoSplash.splashFactory,
                    foregroundColor: ColorStyles.sub1,
                    backgroundColor: ColorStyles.sub3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _switchMode,
                  child: Text(
                    _isModificationMode ? "수정 완료" : "기간/시간 수정",
                    style: const TextStyle(
                      color: ColorStyles.main,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: Obx(() {
                return (_isModificationMode
                    ? _getModificationView()
                    : _getListView());
              }),
            ),
            const SizedBox(
              height: 24,
            ),
            Obx(
              () {
                var disabled = controller.getDuration() == 0;
                return Row(
                  children: [
                    Expanded(
                      child: BottomButton(
                        "완료",
                        onPressed: disabled
                            ? null
                            : () {
                                Get.offAllNamed("/");
                              },
                        backgroundColor:
                            disabled ? ColorStyles.gray2 : ColorStyles.main,
                        color: disabled ? ColorStyles.gray5 : ColorStyles.white,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
