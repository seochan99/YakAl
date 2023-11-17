import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/utilities/enum/add_schedule_result.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Medication/add_dose_view_model.dart';
import 'package:yakal/widgets/Base/bottom_button.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'package:yakal/widgets/Base/outer_frame.dart';
import 'package:yakal/widgets/Medication/dose_add_calendar.dart';
import 'package:yakal/widgets/Medication/medicine_add_cancel_dialog.dart';
import 'package:yakal/widgets/Medication/taking_time_button.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final addDoseViewModel = Get.find<AddDoseViewModel>();
  final doseAddCalendarController = Get.put(DoseAddCalenderController());

  bool isModificationMode = false;
  bool isLoading = false;
  bool isOcr = false;

  void switchMode() {
    setState(() {
      isModificationMode = !isModificationMode;
    });
  }

  void setIsLoading(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  void setIsOcr(bool isOcr) {
    setState(() {
      this.isOcr = isOcr;
    });
  }

  void Function() _onTapSend(
      BuildContext context, DateTime start, DateTime end) {
    return () {
      setIsLoading(true);

      context.loaderOverlay.show();

      addDoseViewModel.addSchedule(start, end, isOcr).then((value) {
        setIsLoading(false);

        context.loaderOverlay.hide();

        late String message;

        switch (value) {
          case EAddScheduleResult.FAIL:
            message = "약 추가에 실패했습니다.";
            break;
          case EAddScheduleResult.SUCCESS:
            message = "복용 스케줄을 추가했습니다.";
            break;
          case EAddScheduleResult.PARTIALLY_SUCCESS:
            message = "약 추가에 성공했지만 추가되지 않은 약이 존재합니다.";
            break;
          default:
            assert(
                false, "[Assertion Failed] Invalid EAddScheduleResult Value.");
            break;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(message),
            duration: const Duration(milliseconds: 3000),
          ),
        );

        Get.delete<AddDoseViewModel>(force: true);
        Get.offAllNamed("/");
      });
    };
  }

  @override
  void initState() {
    super.initState();
    isOcr = Get.arguments["isOcr"] as bool;
  }

  @override
  Widget build(BuildContext context) {
    /* 로딩 상태를 표현하기 위한 LoaderOverlay */
    return LoaderOverlay(
      child: OuterFrame(
        outOfSafeAreaColor: ColorStyles.white,
        safeAreaColor: ColorStyles.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: DefaultBackAppbar(title: "약 추가"),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              /* 최상단 안내 문구 */
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "복약 기간과 시간을\n설정해주세요.",
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
              /* 안내 문구 바로 아래의 버튼 바 */
              Obx(() {
                /* duration: 선택한 기간 일수 */
                final duration = doseAddCalendarController.getDuration();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isModificationMode
                        ?
                        /* 수정 모드인 경우 'XX일 복용' 버튼을 누르면 캘린더 출현 */
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
                                isScrollControlled: true,
                                barrierColor:
                                    const Color.fromRGBO(98, 98, 114, 0.20),
                                builder: (context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 30.0,
                                      horizontal: 20.0,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: ColorStyles.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
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
                                                backgroundColor:
                                                    ColorStyles.main,
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
                                var duration =
                                    doseAddCalendarController.getDuration();
                                return Text(
                                  duration == 0
                                      ? "기간을 정해야 합니다."
                                      : "$duration일 복약",
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
                        :
                        /* 수정 모드가 아닌 경우 'XX일 복용' 은 버튼이 아닌 일반 텍스트 */
                        Text(
                            duration == 0 ? "기간을 정해야 합니다." : "$duration일 복약",
                            style: const TextStyle(
                              color: ColorStyles.gray5,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                    /* 수정 모드가 아닐 경우만 기간/시간 수정 버튼 출혅 */
                    isModificationMode
                        ? Container()
                        : TextButton(
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
                            onPressed: switchMode,
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
                );
              }),
              const SizedBox(
                height: 24,
              ),
              /* 모드에 따라 적절한 위젯을 보여줌. 수정 모드 -> DoseModificationWidget, 일반 모드 -> DoseListWidget */
              Expanded(
                child: isModificationMode
                    ? Obx(() {
                        final modificationList =
                            addDoseViewModel.getModificationList();
                        return ListView.separated(
                          itemCount: modificationList.length,
                          itemBuilder: (context, index) {
                            final modificationElement = modificationList[index];
                            return Column(
                              children: [
                                /* 약 목록 하나를 출력하는 Row */
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        /* 약 사진 (64 by 32) */
                                        Container(
                                          width: 64,
                                          height: 32,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: ColorStyles.gray2,
                                          ),
                                          child: modificationElement
                                                  .item.base64Image.isNotEmpty
                                              ? Image.memory(
                                                  base64Decode(
                                                    modificationElement
                                                        .item.base64Image,
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
                                        addDoseViewModel.deleteItem(
                                          modificationElement.groupIndex,
                                          modificationElement.itemIndex,
                                        );
                                        addDoseViewModel.groupList.refresh();
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
                                              addDoseViewModel.toggle(
                                                modificationElement.groupIndex,
                                                modificationElement.itemIndex,
                                                ETakingTime.values[index],
                                                !modificationElement
                                                    .takingTime[index],
                                              );
                                            },
                                            isTaking: modificationElement
                                                .takingTime[index],
                                            takingTime:
                                                ETakingTime.values[index],
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
                      })
                    : Obx(
                        () => ListView.separated(
                          itemCount: addDoseViewModel.getGroupCount(),
                          itemBuilder: (context, groupIndex) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* 복용 시간에 따른 그룹 제목 스트링 출력 (e.g. "아침, 저녁") */
                                Text(
                                  addDoseViewModel
                                      .getGroupTimeString(groupIndex),
                                  style: const TextStyle(
                                    color: ColorStyles.gray5,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                /* 해당 그룹 안에 있는 약 목록을 출력 */
                                ListView.separated(
                                  /* ListView 안에 있는 ListView 가 Non-Scrollable 하도록 만듬 */
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  /* --------------------------------------------------- */
                                  itemCount: addDoseViewModel
                                      .getItemCountOnGroup(groupIndex),
                                  itemBuilder: (context, itemIndex) {
                                    var oneMedicine = addDoseViewModel
                                        .getOneMedicine(groupIndex, itemIndex);
                                    return Column(
                                      children: [
                                        /* 약 하나의 정보를 보여 주는 Row */
                                        Row(
                                          children: [
                                            /* 약 사진 (64 by 32) */
                                            Container(
                                                width: 64,
                                                height: 32,
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  color: ColorStyles.gray2,
                                                ),
                                                child: oneMedicine
                                                        .base64Image.isNotEmpty
                                                    ? Image.memory(
                                                        base64Decode(
                                                          oneMedicine
                                                              .base64Image,
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
                                              "${oneMedicine.name.length > 15 ? oneMedicine.name.substring(0, 15) : oneMedicine.name}${oneMedicine.name.length > 15 ? "..." : ""}",
                                              style: const TextStyle(
                                                color: ColorStyles.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                  /* 약 정보 Row 사이의 공백 */
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 16,
                                  ),
                                ),
                              ],
                            );
                          },
                          /* 그룹 정보 Row 사이의 공백 */
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 48,
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 24,
              ),
              /* 최하단 버튼 바 */
              Obx(
                () {
                  var start = doseAddCalendarController.rangeStart.value;
                  var end = doseAddCalendarController.rangeEnd.value;

                  var disabled = doseAddCalendarController.getDuration() == 0 ||
                      start == null ||
                      end == null ||
                      !addDoseViewModel.canSend() ||
                      isModificationMode ||
                      addDoseViewModel.getGroupCount() == 0;

                  return Row(
                    children: [
                      /* 취소 버튼 */
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: BottomButton(
                          "취소",
                          onPressed: isLoading
                              ? null
                              : () {
                                  Get.delete<AddDoseViewModel>(force: true);
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierColor:
                                        const Color.fromRGBO(98, 98, 114, 0.4),
                                    builder: (BuildContext context) {
                                      return MedicineAddCancelDialog(
                                          question: "약 추가를 취소하시겠습니까?",
                                          confirmLabel: "취소하기",
                                          cancelLabel: "아니요",
                                          onConfirm: () {
                                            Get.back();
                                            Get.offAllNamed("/");
                                          });
                                    },
                                  );
                                },
                          backgroundColor: ColorStyles.gray1,
                          color: ColorStyles.gray5,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      /* 수정 완료 및 추가하기 버튼 */
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: BottomButton(
                          isModificationMode ? "수정 완료" : "추가하기",
                          onPressed: isModificationMode
                              ? switchMode
                              : disabled || isLoading
                                  ? () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                              "지금은 약 추가가 불가합니다. 다시 시도해주세요."),
                                          duration:
                                              Duration(milliseconds: 1000),
                                        ),
                                      );
                                    }
                                  : _onTapSend(context, start, end),
                          backgroundColor: isModificationMode
                              ? ColorStyles.sub1
                              : ColorStyles.main,
                          color: ColorStyles.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
