import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Profile/user.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'package:intl/intl.dart';

class InfoHospitalScreen extends StatefulWidget {
  final UserViewModel userViewModel = Get.put(UserViewModel());

  InfoHospitalScreen({super.key});

  @override
  State<InfoHospitalScreen> createState() => _InfoHospitalScreenState();
}

class _InfoHospitalScreenState extends State<InfoHospitalScreen> {
  final TextEditingController _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // 완료 버튼 누르면
    void handleAdmissionButtonPress(DateTime selectedDate, String location,
        {required String title}) {
      // addMedicalRecord
      widget.userViewModel.addMedicalRecord(selectedDate, location, title);

      _locationController.clear();

      Navigator.pop(context);
    }

    void showBottomSheet(
      String title,
    ) {
      DateTime? selectedDate;
      String location = '';

      // required title
      showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return WillPopScope(
                onWillPop: () async {
                  // Clear the text in the text field when the back button is pressed
                  _locationController.clear();
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
                              title == 'hospitalization-records'
                                  ? '입원 기록 추가'
                                  : "응급실 방문 기록 추가",
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              title == 'hospitalization-records'
                                  ? '입원 날짜와 장소를 입력하세요.'
                                  : "응급실 방문 날짜와 장소를 입력하세요.",
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                            title == 'hospitalization-records'
                                ? "입원 날짜"
                                : "응급실 방문 날짜",
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
                            title == 'hospitalization-records'
                                ? "입원 장소"
                                : "응급실 방문 장소",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(height: 12),
                        TextField(
                          onChanged: (value) {
                            location = value;
                          },
                          controller: _locationController,
                          decoration: InputDecoration(
                            labelText: title == 'hospitalization-records'
                                ? "입원 장소"
                                : "응급실 방문 장소",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Color(0xff2666f6),
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        ValueListenableBuilder(
                            valueListenable: _locationController,
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

    void showAdmissionBottomSheet() {
      // Show the admission bottom sheet
      showBottomSheet('hospitalization-records');
    }

    void showEmergencyRoomBottomSheet() {
      // Show the emergency room bottom sheet
      showBottomSheet('emergency-records');
    }

    Widget buildHospitalRecords({required String title}) {
      var hospitalRecordList =
          widget.userViewModel.user.value.hospitalRecordList;

      if (hospitalRecordList != null) {
        List<dynamic> filteredRecords = title == 'hospitalization-records'
            ? hospitalRecordList.admissionRecords
            : hospitalRecordList.emergencyRoomVisits;

        return Column(
          children: filteredRecords.asMap().entries.map((entry) {
            final HospitalRecord record = entry.value;

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
                    widget.userViewModel.removeMedicalRecord(title, record.id);
                    return;
                  },
                  child: SvgPicture.asset(
                    'assets/icons/icon-bin.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
                title: Text(
                  '${(record).date} / ${(record).location}',
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
        child: DefaultBackAppbar(title: "병원 기록 추가"),
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
                          '입원 기록',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 16),
                        // 리스트 가져오기
                        Obx(
                          () => widget.userViewModel.user.value
                                          .hospitalRecordList !=
                                      null &&
                                  widget
                                      .userViewModel
                                      .user
                                      .value
                                      .hospitalRecordList!
                                      .admissionRecords
                                      .isNotEmpty
                              ? buildHospitalRecords(
                                  // emergency
                                  title: 'hospitalization-records')
                              : const SizedBox.shrink(),
                        ),

                        const SizedBox(height: 16),
                        TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: ColorStyles.gray1,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: showAdmissionBottomSheet,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/plus-circle.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 14),
                                const Text(
                                  "날짜/장소 추가",
                                  style: TextStyle(
                                      color: ColorStyles.gray5,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )),
                        const SizedBox(height: 48),
                        const Text(
                          '응급실 방문 기록',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),

                        const SizedBox(height: 16),
                        Obx(
                          () => widget.userViewModel.user.value
                                          .hospitalRecordList !=
                                      null &&
                                  widget
                                      .userViewModel
                                      .user
                                      .value
                                      .hospitalRecordList!
                                      .emergencyRoomVisits
                                      .isNotEmpty
                              ? buildHospitalRecords(title: 'emergency-records')
                              : const SizedBox.shrink(),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: ColorStyles.gray1,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: showEmergencyRoomBottomSheet,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/plus-circle.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 14),
                                const Text(
                                  "날짜/장소 추가",
                                  style: TextStyle(
                                      color: ColorStyles.gray5,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )),
                        // InfoBohoList(),
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
