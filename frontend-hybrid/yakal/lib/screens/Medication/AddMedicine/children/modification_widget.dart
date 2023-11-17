import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Medication/add_dose_view_model.dart';
import 'package:yakal/widgets/Medication/taking_time_button.dart';

class DoseModificationWidget extends StatefulWidget {
  final AddDoseViewModel addDoseViewModel = Get.find<AddDoseViewModel>();

  DoseModificationWidget({super.key});

  @override
  State<DoseModificationWidget> createState() => _DoseModificationWidgetState();
}

class _DoseModificationWidgetState extends State<DoseModificationWidget> {
  @override
  Widget build(BuildContext context) {
    /* 현재 약 목록에서 그룹 안에 존재하는 중첩 아이템들을 하나의 배열로 평탄화 */
    final modificationList = widget.addDoseViewModel.getModificationList();

    /* 현재 약 목록의 복용 시간을 수정 가능하도록 출력 */
    return ListView.separated(
      itemCount: modificationList.length,
      itemBuilder: (context, index) {
        final modificationElement = modificationList[index];
        return Column(
          children: [
            /* 약 목록 하나를 출력하는 Row */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    /* 약 사진 (64 by 32) */
                    Container(
                      width: 64,
                      height: 32,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: ColorStyles.gray2,
                      ),
                      child: modificationElement.item.base64Image.isNotEmpty
                          ? Image.memory(
                              base64Decode(
                                modificationElement.item.base64Image,
                              ),
                              fit: BoxFit.cover,
                            )
                          : SvgPicture.asset(
                              "assets/icons/img-mainpill-default.svg",
                              width: 64,
                              height: 32,
                            ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    /* 약 이름 */
                    Text(
                      "${modificationElement.item.name.length > 15 ? modificationElement.item.name.substring(0, 15) : modificationElement.item.name}${modificationElement.item.name.length > 15 ? "..." : ""}",
                      style: const TextStyle(
                        color: ColorStyles.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                /* 삭제 버튼 */
                IconButton(
                  style: IconButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  padding: const EdgeInsets.all(0.0),
                  icon: SvgPicture.asset(
                    "assets/icons/icon-bin.svg",
                    width: 20,
                    height: 20,
                  ),
                  color: ColorStyles.main,
                  onPressed: () {
                    widget.addDoseViewModel.deleteItem(
                      modificationElement.groupIndex,
                      modificationElement.itemIndex,
                    );
                  },
                ),
              ],
            ),
            /* 약 목록 하나의 복용 시간을 수정할 수 있는 버튼 그룹 */
            Row(
              children: List.generate(
                ETakingTime.values.sublist(0, 4).length,
                (index) {
                  return Row(
                    children: [
                      /* 복용 시간 수정 버튼 */
                      TakingTimeButton(
                        onChanged: () {
                          widget.addDoseViewModel.toggle(
                            modificationElement.groupIndex,
                            modificationElement.itemIndex,
                            ETakingTime.values[index],
                            !modificationElement.takingTime[index],
                          );
                        },
                        isTaking: modificationElement.takingTime[index],
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
      /* 약 목록 아이템 Row 사이의 공백 */
      separatorBuilder: (context, index) => const SizedBox(
        height: 24,
      ),
    );
  }
}
