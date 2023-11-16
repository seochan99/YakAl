import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yakal/screens/Medication/AddMedicine/children/list_widget.dart';
import 'package:yakal/screens/Medication/AddMedicine/children/modification_widget.dart';
import 'package:yakal/utilities/enum/add_schedule_result.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Medication/add_dose_review_view_model.dart';
import 'package:yakal/viewModels/Medication/add_dose_view_model.dart';
import 'package:yakal/widgets/Base/bottom_button.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'package:yakal/widgets/Base/outer_frame.dart';
import 'package:yakal/widgets/Medication/dose_add_calendar.dart';
import 'package:yakal/widgets/Medication/medicine_add_cancel_dialog.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final addDoseViewModel = Get.find<AddDoseViewModel>();
  final addDoseReviewViewModel = Get.put(AddDoseReviewViewModel());
  final doseAddCalendarController = Get.put(DoseAddCalenderController());

  void Function() _onTapSend(
      BuildContext context, DateTime start, DateTime end) {
    return () {
      addDoseReviewViewModel.setIsLoading(true);

      context.loaderOverlay.show();

      addDoseViewModel
          .addSchedule(start, end, addDoseReviewViewModel.isOcr.value)
          .then((value) {
        addDoseReviewViewModel.setIsLoading(false);

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

    addDoseReviewViewModel.setIsOcr(
      Get.arguments["isOcr"] as bool,
    );
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
                    addDoseReviewViewModel.isModificationMode.value
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
                    addDoseReviewViewModel.isModificationMode.value
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
                            onPressed: addDoseReviewViewModel.switchMode,
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
                child: Obx(() {
                  if (addDoseViewModel.getGroupList().isEmpty) {
                    return Container();
                  }

                  return addDoseReviewViewModel.isModificationMode.value
                      ? DoseModificationWidget()
                      : DoseListWidget();
                }),
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
                      addDoseReviewViewModel.isModificationMode.value ||
                      addDoseViewModel.getGroupCount() == 0;

                  return Row(
                    children: [
                      /* 취소 버튼 */
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: BottomButton(
                          "취소",
                          onPressed: addDoseReviewViewModel.isLoading.value
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
                          addDoseReviewViewModel.isModificationMode.value
                              ? "수정 완료"
                              : "추가하기",
                          onPressed:
                              disabled || addDoseReviewViewModel.isLoading.value
                                  ? addDoseReviewViewModel.switchMode
                                  : _onTapSend(context, start, end),
                          backgroundColor:
                              addDoseReviewViewModel.isModificationMode.value
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
