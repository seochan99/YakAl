import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/utilities/enum/add_schedule_result.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Medication/dose_list_view_model.dart';
import 'package:yakal/widgets/Base/bottom_button.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'package:yakal/widgets/Base/outer_frame.dart';
import 'package:yakal/widgets/Medication/dose_add_calendar.dart';
import 'package:yakal/widgets/Medication/medicine_add_cancel_dialog.dart';
import 'package:yakal/widgets/Medication/taking_time_button.dart';

class AddMedicineScreen extends StatefulWidget {
  final doseListViewModel = Get.find<AddDoseViewModel>();
  final doseAddCalendarController = Get.put(DoseAddCalenderController());

  AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  bool _isModificationMode = false;
  bool _isLoading = false;

  void _switchMode() {
    setState(() {
      _isModificationMode = !_isModificationMode;
    });
  }

  void Function() _onTapSend(DateTime start, DateTime end) {
    return () {
      setState(() {
        _isLoading = true;
      });

      context.loaderOverlay.show();

      widget.doseListViewModel.addSchedule(start, end).then((value) {
        setState(() {
          _isLoading = false;
        });

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
                false, "[Assertion Failed] Invaild EAddScheduleResult Value.");
            break;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(message),
            duration: const Duration(milliseconds: 3000),
          ),
        );

        widget.doseListViewModel.clear();
        Get.offAllNamed("/");
      });
    };
  }

  Widget _getListView() {
    return ListView.separated(
      itemCount: widget.doseListViewModel.getGroupCount() + 1,
      itemBuilder: (context, groupIndex) {
        if (groupIndex == widget.doseListViewModel.getGroupCount()) {
          return widget.doseListViewModel.getNotAddableCount() == 0
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "추가 불가 약물",
                      style: TextStyle(
                        color: ColorStyles.red,
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
                      itemCount: widget.doseListViewModel.getNotAddableCount(),
                      itemBuilder: (context, index) {
                        var notAddableItem =
                            widget.doseListViewModel.getNotAddableItem(index);

                        return Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 64,
                                    height: 32,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: ColorStyles.gray2,
                                    ),
                                    child: notAddableItem.base64Image != ""
                                        ? Image.memory(
                                            base64Decode(
                                              notAddableItem.base64Image,
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
                                Text(
                                  notAddableItem.name,
                                  style: const TextStyle(
                                    color: ColorStyles.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                    ),
                  ],
                );
        }

        final String groupTime =
            widget.doseListViewModel.getGroupTimeString(groupIndex);

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
                  widget.doseListViewModel.getItemCountOnGroup(groupIndex),
              itemBuilder: (context, itemIndex) {
                var oneMedicine = widget.doseListViewModel
                    .getOneMedicine(groupIndex, itemIndex);
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            width: 64,
                            height: 32,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: ColorStyles.gray2,
                            ),
                            child: oneMedicine.base64Image != ""
                                ? Image.memory(
                                    base64Decode(
                                      oneMedicine.base64Image,
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
                        Text(
                          oneMedicine.name,
                          style: const TextStyle(
                            color: ColorStyles.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                );
              },
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
    var modificationList = widget.doseListViewModel.getModificationList();

    return ListView.separated(
      itemCount: modificationList.length,
      itemBuilder: (context, index) {
        var modificationElement = modificationList[index];
        return Column(
          children: [
            Row(
              children: [
                Container(
                    width: 64,
                    height: 32,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: ColorStyles.gray2,
                    ),
                    child: modificationElement["item"].base64Image != null
                        ? Image.memory(
                            base64Decode(
                              modificationElement["item"].base64Image!,
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
                          widget.doseListViewModel.toggle(
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          isScrollControlled: true,
                          barrierColor: const Color.fromRGBO(98, 98, 114, 0.20),
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
                          var duration =
                              widget.doseAddCalendarController.getDuration();
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
                        var duration =
                            widget.doseAddCalendarController.getDuration();
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
                  _isModificationMode
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
                          onPressed: _switchMode,
                          child: Text(
                            _isModificationMode ? "" : "기간/시간 수정",
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
                  var start = widget.doseAddCalendarController.rangeStart.value;
                  var end = widget.doseAddCalendarController.rangeEnd.value;

                  var disabled =
                      widget.doseAddCalendarController.getDuration() == 0 ||
                          start == null ||
                          end == null ||
                          !widget.doseListViewModel.canSend() ||
                          _isModificationMode;

                  return Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: BottomButton(
                          "취소",
                          onPressed: _isLoading
                              ? null
                              : () {
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
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: BottomButton(
                          _isModificationMode ? "수정 완료" : "추가하기",
                          // onPressed: _isModificationMode || _isLoading
                          //     ? _switchMode
                          //     : _onTapSend(start, end),
                          onPressed: disabled || _isLoading
                              ? _switchMode
                              : _onTapSend(start, end),
                          backgroundColor: _isModificationMode
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
