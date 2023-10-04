import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Profile/user.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'package:intl/intl.dart';

class InfoStarScreen extends StatefulWidget {
  final UserViewModel userViewModel = Get.put(UserViewModel());

  InfoStarScreen({super.key});

  @override
  State<InfoStarScreen> createState() => _InfoStarScreenState();
}

class _InfoStarScreenState extends State<InfoStarScreen> {
  final TextEditingController itemController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // 완료버튼 누르면 작동하는 함수
    void handleAdmissionButtonPress(DateTime selectedDate, String location,
        {required String title}) {
      title == 'admissionRecords'
          ? widget.userViewModel.addHospitalRecord(selectedDate, location)
          : widget.userViewModel.addEmergencyRoomVisit(selectedDate, location);
      itemController.clear();
      Navigator.pop(context);
    }

    String getTitleFromRecordType(String recordType) {
      String title = '';

      switch (recordType) {
        case 'underlyingConditions':
          title = '기저 질환';
          break;
        case 'allergies':
          title = '알러지';
          break;
        case 'falls':
          title = '낙상 사고';
          break;
        case 'oneYearDisease':
          title = '1년 내 질병';
          break;
        case 'healthMedications':
          title = '복약중인 건강식품';
          break;
        default:
          title = 'Unknown';
          break;
      }

      return title;
    }

    void showBottomSheet(
      String title,
    ) {
      DateTime? selectedDate;
      String location = '';
      showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return WillPopScope(
                onWillPop: () async {
                  // Clear the text in the text field when the back button is pressed
                  itemController.clear();
                  return true;
                },
                child: Container(
                  height: MediaQuery.of(context).viewInsets.bottom + 500,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 26, 20, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getTitleFromRecordType(title),
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                            title == "admissionRecords" ? "입원 날짜" : "응급실 방문 날짜",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                selectedDate = picked;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today),
                                const SizedBox(width: 8.0),
                                Text(
                                  selectedDate != null
                                      ? "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}"
                                      : "날짜 선택",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: selectedDate != null
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                            title == "admissionRecords" ? "입원 장소" : "응급실 방문 장소",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(height: 12),
                        TextField(
                          onChanged: (value) {
                            location = value;
                          },
                          controller: itemController,
                          decoration: InputDecoration(
                            labelText: title == "admissionRecords"
                                ? "입원 장소"
                                : "응급실 방문 장소",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        ValueListenableBuilder(
                            valueListenable: itemController,
                            builder: (context, value, child) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  foregroundColor: Colors.white,
                                  backgroundColor: selectedDate != null &&
                                          location.isNotEmpty
                                      ? const Color(0xff2666f6)
                                      : Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed:
                                    selectedDate != null && location.isNotEmpty
                                        ? () {
                                            handleAdmissionButtonPress(
                                                title: title,
                                                selectedDate!,
                                                location);
                                          }
                                        : null,
                                child: const Text(
                                  "완료",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    }

    // 병명 추가 버튼 누르면 작동하는 함수
    Widget buildInfoStarRecords({required String title}) {
      var specialNote = widget.userViewModel.user.value.specialNote;

      List<dynamic> filteredRecords = [];

      if (specialNote != null) {
        switch (title) {
          case 'admissionRecords':
            filteredRecords = specialNote.underlyingConditions;
            break;
          case 'allergies':
            filteredRecords = specialNote.allergies;
            break;
          case 'falls':
            filteredRecords = specialNote.falls;
            break;
          case 'oneYearDisease':
            filteredRecords = specialNote.oneYearDisease;
            break;
          case 'healthMedications':
            filteredRecords = specialNote.healthMedications;
            break;
          default:
            filteredRecords = [];
        }

        return Column(
          children: filteredRecords.asMap().entries.map((entry) {
            final int index = entry.key;
            final dynamic record = entry.value;

            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorStyles.gray2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                trailing: InkWell(
                  onTap: () {
                    switch (title) {
                      case 'underlyingConditions':
                        widget.userViewModel.removeUnderlyingCondition(index);
                        break;
                      case 'allergies':
                        widget.userViewModel.removeAllergy(index);
                        break;
                      case 'falls':
                        widget.userViewModel.removeFall(index);
                        break;
                      case 'oneYearDisease':
                        widget.userViewModel.removeOneYearDisease(index);
                        break;
                      case 'healthMedications':
                        widget.userViewModel.removeHealthMedications(index);
                        break;
                      default:
                        break;
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/icons/icon-bin.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
                title: Text(
                  '${DateFormat('yyyy-MM-dd').format(record.date)} / ${record.location}',
                  style: const TextStyle(
                    color: ColorStyles.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      } else {
        // Display nothing if hospitalRecordList is null or admissionRecords is null
        return const SizedBox.shrink();
      }
    }

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: "특이사항 추가"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '기저 질환',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        const Text("평소 앓고 있는 만성적 질병",
                            style: TextStyle(
                              color: ColorStyles.gray5,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(height: 8),
                        Obx(
                          () => widget.userViewModel.user.value
                                          .hospitalRecordList !=
                                      null &&
                                  widget.userViewModel.user.value.specialNote!
                                      .underlyingConditions.isNotEmpty
                              ? buildInfoStarRecords(
                                  // emergency
                                  title: "underlyingConditions")
                              : const SizedBox.shrink(),
                        ),
                        const SizedBox(height: 16),
                        InfoAddBtnWidget(
                          content: "병명 추가",
                          actionSheet: () =>
                              {showBottomSheet("underlyingConditions")},
                        ),
                        const SizedBox(height: 48),
                        /* ---------------- 알러지 ---------------- */

                        const Text(
                          '알러지',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 16),
                        Obx(
                          () => widget.userViewModel.user.value
                                          .hospitalRecordList !=
                                      null &&
                                  widget.userViewModel.user.value.specialNote!
                                      .allergies.isNotEmpty
                              ? buildInfoStarRecords(title: "allergies")
                              : const SizedBox.shrink(),
                        ),
                        const SizedBox(height: 16),
                        InfoAddBtnWidget(
                          content: "항목 추가",
                          actionSheet: () => {showBottomSheet("allergies")},
                        ),
                        const SizedBox(height: 48),
                        /* ---------------- 낙상 사고 ---------------- */
                        const Text(
                          '낙상 사고',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        const Text("의도하지 않게 넘어지거나 떨어져서 다치는 것",
                            style: TextStyle(
                              color: ColorStyles.gray5,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(height: 8),
                        Obx(
                          () => widget.userViewModel.user.value
                                          .hospitalRecordList !=
                                      null &&
                                  widget.userViewModel.user.value.specialNote!
                                      .falls.isNotEmpty
                              ? buildInfoStarRecords(
                                  // emergency
                                  title: "falls")
                              : const SizedBox.shrink(),
                        ),
                        const SizedBox(height: 16),
                        InfoAddBtnWidget(
                          content: "날짜 추가",
                          actionSheet: () => {showBottomSheet("falls")},
                        ),
                        const SizedBox(height: 48),
                        /* ---------------- 복약중인 건강식품 ---------------- */
                        const Text(
                          '복용 중인 건강기능식품',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 16),
                        Obx(
                          () => widget.userViewModel.user.value
                                          .hospitalRecordList !=
                                      null &&
                                  widget.userViewModel.user.value.specialNote!
                                      .healthMedications.isNotEmpty
                              ? buildInfoStarRecords(title: "healthMedications")
                              : const SizedBox.shrink(),
                        ),
                        const SizedBox(height: 16),
                        InfoAddBtnWidget(
                          content: "항목 추가",
                          actionSheet: () =>
                              {showBottomSheet("healthMedications")},
                        ),
                        const SizedBox(height: 48),
                        /* ---------------- 진단 병 목록 ---------------- */
                        const Text(
                          '1년간 처단 받은 (진단)병',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 16),
                        Obx(
                          () => widget.userViewModel.user.value.specialNote !=
                                      null &&
                                  widget.userViewModel.user.value.specialNote!
                                      .oneYearDisease.isNotEmpty
                              ? buildInfoStarRecords(title: "oneYearDisease")
                              : const SizedBox.shrink(),
                        ),
                        const SizedBox(height: 16),
                        InfoAddBtnWidget(
                          content: "병명 추가",
                          actionSheet: () =>
                              {showBottomSheet("oneYearDisease")},
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoAddBtnWidget extends StatelessWidget {
  final String content;
  final VoidCallback actionSheet;

  const InfoAddBtnWidget(
      {super.key, required this.actionSheet, required this.content});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: ColorStyles.gray1,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: actionSheet,
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/plus-circle.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 14),
            Text(
              content,
              style: const TextStyle(
                  color: ColorStyles.gray5,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ));
  }
}
