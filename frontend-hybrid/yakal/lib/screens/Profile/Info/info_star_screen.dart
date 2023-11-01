import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/models/Profile/special_note_model.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/special_list_view_model.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'package:yakal/widgets/Profile/ProfileInfo/profle_info_add_btn_widget.dart';

class InfoStarScreen extends StatefulWidget {
  final SpecialListViewModel userViewModel = Get.put(SpecialListViewModel());

  InfoStarScreen({super.key});

  @override
  State<InfoStarScreen> createState() => _InfoStarScreenState();
}

class _InfoStarScreenState extends State<InfoStarScreen> {
  final TextEditingController itemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.userViewModel.loadSpeicalNote('medical-histories');
    widget.userViewModel.loadSpeicalNote('dietary-supplements');
    widget.userViewModel.loadSpeicalNote('underlying-conditions');
    widget.userViewModel.loadSpeicalNote('allergies');
    widget.userViewModel.loadSpeicalNote('falls');
  }

  @override
  Widget build(BuildContext context) {
    // 완료버튼 누르면 작동하는 함수
    void handleAdmissionButtonPress(dynamic item, {required String title}) {
      widget.userViewModel.addSpecialNoteItem(title, item!);

      itemController.clear();
      Navigator.pop(context);
      Get.snackbar(
        '추가 완료',
        "특이사항이 추가 완료됏습니다!",
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        duration: const Duration(seconds: 1, microseconds: 500),
        snackPosition: SnackPosition.TOP,
        backgroundColor: ColorStyles.gray1,
        colorText: Colors.black,
      );
    }

    String getTitleFromRecordType(String recordType) {
      String title = '';
      switch (recordType) {
        case 'underlying-conditions':
          title = '기저 질환';
          break;
        case 'allergies':
          title = '알러지';
          break;
        case 'falls':
          title = '낙상 사고';
          break;
        case 'medical-histories':
          title = '1년 내 질병';
          break;
        case 'dietary-supplements':
          title = '복약중인 건강식품';
          break;
        default:
          title = '알수없음';
          break;
      }

      return title;
    }

    void showBottomSheet(
      String title,
    ) {
      dynamic item;
      showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return WillPopScope(
                onWillPop: () async {
                  itemController.clear();
                  return true;
                },
                child: Container(
                  height: MediaQuery.of(context).viewInsets.bottom + 400,
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
                              '${getTitleFromRecordType(title)} 추가',
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(getTitleFromRecordType(title),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(height: 12),
                        title == 'falls'
                            ? InkWell(
                                onTap: () async {
                                  DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    // color white

                                    // background color white
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      item = picked;
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
                                        item != null
                                            ? '${item!.year}-${item!.month}-${item!.day}'
                                            : '날짜 선택',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: item != null
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : TextField(
                                onChanged: (value) {
                                  item = value;
                                },
                                controller: itemController,
                                decoration: InputDecoration(
                                  labelText: '항목 입력',
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
                            valueListenable: itemController,
                            builder: (context, value, child) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  foregroundColor: Colors.white,
                                  backgroundColor: item != null
                                      ? const Color(0xff2666f6)
                                      : Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed: item != null
                                    ? () {
                                        handleAdmissionButtonPress(
                                            title: title, item);
                                      }
                                    : null,
                                child: const Text(
                                  '완료',
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

    // 병명 버튼 누르면 작동하는 함수
    Widget buildInfoStarRecords({required String title}) {
      var specialNote = widget.userViewModel.user.value.specialNote;

      List<dynamic> filteredRecords = [];

      if (specialNote != null) {
        switch (title) {
          case 'underlying-conditions':
            filteredRecords = specialNote.underlyingConditions;
            break;
          case 'allergies':
            filteredRecords = specialNote.allergies;
            break;
          case 'falls':
            filteredRecords = specialNote.falls;
            break;
          case 'medical-histories':
            filteredRecords = specialNote.diagnosis;
            break;
          case 'dietary-supplements':
            filteredRecords = specialNote.healthfood;
            break;
          default:
            filteredRecords = [];
        }

        return Column(
          children: filteredRecords.asMap().entries.map((entry) {
            final dynamic record = entry.value;

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border.all(color: ColorStyles.gray2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                trailing: InkWell(
                  onTap: () {
                    // DELETE
                    widget.userViewModel
                        .removeSpecialNoteItem(title, record.id);

                    Get.snackbar(
                      '삭제 완료',
                      "특이사항이 삭제 완료됐습니다!",
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      duration: const Duration(seconds: 1, microseconds: 500),
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: ColorStyles.gray1,
                      colorText: Colors.black,
                    );
                    return;
                  },
                  child: SvgPicture.asset(
                    'assets/icons/icon-bin.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
                title: Text(
                  (record as ItemWithNameAndId).name,
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
        child: DefaultBackAppbar(title: '특이사항 추가'),
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
                        const Text('평소 앓고 있는 만성적 질병',
                            style: TextStyle(
                              color: ColorStyles.gray5,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(height: 8),
                        // widget.userViewModel.user.value.specialNote!.underlyingConditions
                        //  log widget.userViewModel.user.value.specialNote!.underlyingConditions
                        Obx(
                          () => widget.userViewModel.user.value.specialNote !=
                                      null &&
                                  widget.userViewModel.user.value.specialNote!
                                      .underlyingConditions.isNotEmpty
                              ? buildInfoStarRecords(
                                  // emergency
                                  title: 'underlying-conditions')
                              : const SizedBox.shrink(),
                        ),
                        const SizedBox(height: 16),
                        InfoAddBtnWidget(
                          content: '병명 추가',
                          actionSheet: () =>
                              {showBottomSheet('underlying-conditions')},
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
                          () {
                            if (widget.userViewModel.user.value.specialNote ==
                                null) {
                              return const SizedBox.shrink();
                            }
                            return buildInfoStarRecords(title: 'allergies');
                          },
                        ),
                        const SizedBox(height: 16),
                        InfoAddBtnWidget(
                          content: '항목 추가',
                          actionSheet: () => {showBottomSheet('allergies')},
                        ),
                        const SizedBox(height: 48),
                        /* ---------------- 낙상 사고 ---------------- */
                        const Text(
                          '낙상 사고',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        const Text('의도하지 않게 넘어지거나 떨어져서 다치는 것',
                            style: TextStyle(
                              color: ColorStyles.gray5,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(height: 8),
                        Obx(
                          () => widget.userViewModel.user.value.specialNote !=
                                      null &&
                                  widget.userViewModel.user.value.specialNote!
                                      .falls.isNotEmpty
                              ? buildInfoStarRecords(
                                  // emergency
                                  title: 'falls')
                              : const SizedBox.shrink(),
                        ),
                        const SizedBox(height: 16),
                        InfoAddBtnWidget(
                          content: '날짜 추가',
                          actionSheet: () => {showBottomSheet('falls')},
                        ),
                        const SizedBox(height: 48),
                        /* ---------------- 복약중인 건강식품 ---------------- */
                        const Text(
                          '복용 중인 건강기능식품',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 16),
                        // GET
                        Obx(
                          () {
                            if (widget.userViewModel.user.value.specialNote ==
                                null) {
                              return const SizedBox.shrink();
                            }
                            return buildInfoStarRecords(
                                title: 'dietary-supplements');
                          },
                        ),
                        // ADD
                        const SizedBox(height: 16),
                        InfoAddBtnWidget(
                          content: '항목 추가',
                          actionSheet: () =>
                              {showBottomSheet('dietary-supplements')},
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
                          () {
                            if (widget.userViewModel.user.value.specialNote ==
                                null) {
                              return const SizedBox.shrink();
                            }
                            return buildInfoStarRecords(
                                title: 'medical-histories');
                          },
                        ),
                        const SizedBox(height: 16),
                        InfoAddBtnWidget(
                          content: '병명 추가',
                          actionSheet: () =>
                              {showBottomSheet('medical-histories')},
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
