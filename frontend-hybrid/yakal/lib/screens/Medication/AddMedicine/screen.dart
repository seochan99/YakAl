import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yakal/screens/Medication/AddMedicine/children/list_widget.dart';
import 'package:yakal/screens/Medication/AddMedicine/children/modification_widget.dart';
import 'package:yakal/utilities/enum/add_schedule_result.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Medication/add_dose_review_view_model.dart';
import 'package:yakal/viewModels/Medication/dose_list_view_model.dart';
import 'package:yakal/widgets/Base/bottom_button.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'package:yakal/widgets/Base/outer_frame.dart';
import 'package:yakal/widgets/Medication/dose_add_calendar.dart';
import 'package:yakal/widgets/Medication/medicine_add_cancel_dialog.dart';

class AddMedicineScreen extends StatefulWidget {
  final addDoseViewModel = Get.find<AddDoseViewModel>();
  final addDoseReviewViewModel = Get.put(AddDoseReviewViewModel());
  final doseAddCalendarController = Get.put(DoseAddCalenderController());

  AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  void Function() _onTapSend(DateTime start, DateTime end) {
    return () {
      widget.addDoseReviewViewModel.setIsLoading(true);

      context.loaderOverlay.show();

      widget.addDoseViewModel.addSchedule(start, end).then((value) {
        widget.addDoseReviewViewModel.setIsLoading(false);

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

        widget.addDoseViewModel.clear();
        Get.offAllNamed("/");
      });
    };
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
                  if (widget.addDoseReviewViewModel.isModificationMode.value)
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
                  widget.addDoseReviewViewModel.isModificationMode.value
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
                          onPressed: widget.addDoseReviewViewModel.switchMode,
                          child: Text(
                            widget.addDoseReviewViewModel.isModificationMode
                                    .value
                                ? ""
                                : "기간/시간 수정",
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
                  return (widget.addDoseReviewViewModel.isModificationMode.value
                      ? DoseModificationWidget()
                      : DoseListWidget());
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
                          !widget.addDoseViewModel.canSend() ||
                          widget
                              .addDoseReviewViewModel.isModificationMode.value;

                  return Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: BottomButton(
                          "취소",
                          onPressed: widget
                                  .addDoseReviewViewModel.isLoading.value
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
                          widget.addDoseReviewViewModel.isModificationMode.value
                              ? "수정 완료"
                              : "추가하기",
                          // onPressed: _isModificationMode || _isLoading
                          //     ? _switchMode
                          //     : _onTapSend(start, end),
                          onPressed: disabled ||
                                  widget.addDoseReviewViewModel.isLoading.value
                              ? widget.addDoseReviewViewModel.switchMode
                              : _onTapSend(start, end),
                          backgroundColor: widget.addDoseReviewViewModel
                                  .isModificationMode.value
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
