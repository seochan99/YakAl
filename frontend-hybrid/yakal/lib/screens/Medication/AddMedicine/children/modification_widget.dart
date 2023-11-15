import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Medication/dose_list_view_model.dart';
import 'package:yakal/widgets/Medication/taking_time_button.dart';

class DoseModificationWidget extends StatelessWidget {
  final AddDoseViewModel addDoseViewModel = Get.find<AddDoseViewModel>();

  DoseModificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /* 현재 약 목록에서 그룹 안에 존재하는 중첩 아이템들을 하나의 배열로 평탄화 */
    final modificationList = addDoseViewModel.getModificationList();

    /* 현재 약 목록의 복용 시간을 수정 가능하도록 출력 */
    return ListView.separated(
      itemCount: modificationList.length,
      itemBuilder: (context, index) {
        final modificationElement = modificationList[index];
        return Column(
          children: [
            /* 약 목록 하나를 출력하는 Row */
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
                          )),
                const SizedBox(
                  width: 10,
                ),
                /* 약 이름 */
                Text(
                  modificationElement.item.name,
                  style: const TextStyle(
                    color: ColorStyles.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
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
                          addDoseViewModel.toggle(
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