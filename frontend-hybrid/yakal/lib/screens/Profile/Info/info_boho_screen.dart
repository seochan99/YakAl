import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yakal/models/Profile/user.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/guardian_controller.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'package:yakal/widgets/Base/input_horizontal_text_field_widget.dart';

class InfoBohoScreen extends StatefulWidget {
  final UserViewModel userViewModel = Get.put(UserViewModel());

  InfoBohoScreen({super.key});

  @override
  _InfoBohoScreenState createState() => _InfoBohoScreenState();
}

class _InfoBohoScreenState extends State<InfoBohoScreen> {
  String bohoName = '';
  String bohoBirth = '';
  int bohoId = 0;
  bool isSelectedBoho = false;
  bool isSelectedSearch = false;

  final TextEditingController _bohoNameController = TextEditingController();
  DateTime? _selectedBirthDate;
  final GuardianController guardianController = Get.put(GuardianController());

  @override
  void dispose() {
    _bohoNameController.dispose();
    super.dispose();
  }

  void _handleButtonPress() {
    widget.userViewModel.addOrUpdateGuardian(bohoId);
    _bohoNameController.clear();

    // 검색완료
    Get.snackbar(
      '보호자 정보 추가',
      '보호자 정보 추가 완료(새로 추가시 업데이트 됩니다!)',
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      duration: const Duration(seconds: 2, microseconds: 500),
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorStyles.gray1,
      colorText: Colors.black,
    );

    setState(() {
      _selectedBirthDate = null;
    });
    // Navigator.pop(context);
  }

  void _handleButtonPress2() async {
    final String guardianName = _bohoNameController.text;
    final String birth = DateFormat('yyyy-MM-dd').format(_selectedBirthDate!);

    // 검색완료
    Get.snackbar(
      '보호자 정보 검색',
      '보호자 정보 검색 완료(보호자 이름, 생년월일을 정확히 입력해주셔야 해요!)',
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      duration: const Duration(seconds: 2, microseconds: 500),
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorStyles.gray1,
      colorText: Colors.black,
    );

    await guardianController.getGuardians(guardianName, birth);
    // 상태를 갱신하여 UI를 업데이트합니다.
    setState(() {
      // 비우지 말기
      // _bohoNameController.clear();
      // _selectedBirthDate = null;
    });
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.white,
              onPrimary: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedBirthDate) {
      setState(() {
        _selectedBirthDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: "보호자 정보"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '보호자 성함',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 16),
                      InputHorizontalTextFieldWidget(
                        nickNameController: _bohoNameController,
                        title: '보호자 성함',
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '보호자 생년월일',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => _selectBirthDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today),
                              const SizedBox(width: 8.0),
                              Text(
                                _selectedBirthDate != null
                                    ? "${_selectedBirthDate!.year}-${_selectedBirthDate!.month}-${_selectedBirthDate!.day}"
                                    : "선택하세요",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: _selectedBirthDate != null
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // 등록된 보호자
                      const SizedBox(height: 24),
                      const Text(
                        '등록된 보호자',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 16),
                      Obx(() {
                        return Text(
                          widget.userViewModel.user.value.guardian == null
                              ? '등록된 보호자가 없습니다.'
                              : '${widget.userViewModel.user.value.guardian!.name}님 (${widget.userViewModel.user.value.guardian!.birthDate})',
                        );
                      }),
                      const SizedBox(height: 24),
                      const Text(
                        '보호자를 선택해주세요!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 16),
                      // 검색 결과로 나오는 보호자

                      Obx(() {
                        return guardianController.guardians.isEmpty
                            ? const Text('검색된 보호자가 없습니다.')
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: guardianController.guardians.length,
                                itemBuilder: (context, index) {
                                  final guardian =
                                      guardianController.guardians[index];
                                  return Card(
                                    child: InkWell(
                                      onTap: () {
                                        // _handleButtonPress();
                                        setState(() {
                                          bohoId = guardian.id;
                                          isSelectedBoho = true;
                                        });
                                      },
                                      highlightColor:
                                          Colors.blue.withOpacity(0.3),
                                      child: ListTile(
                                        title: Text(guardian.name),
                                        subtitle: Text(
                                          guardian.birthDate,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                      })
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20.0,
                0.0,
                20.0,
                30,
              ),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _bohoNameController,
                builder: (context, value, child) {
                  final isButtonEnabled = value.text.isNotEmpty &&
                      _selectedBirthDate != null &&
                      !isSelectedBoho;
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      foregroundColor: Colors.white,
                      backgroundColor: isButtonEnabled
                          ? const Color(0xff2666f6)
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: isButtonEnabled ? _handleButtonPress2 : null,
                    child:
                        const Text("검색 하기", style: TextStyle(fontSize: 20.0)),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20.0,
                0.0,
                20.0,
                30,
              ),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _bohoNameController,
                builder: (context, value, child) {
                  final isButtonEnabled = isSelectedBoho;
                  return isButtonEnabled
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            foregroundColor: Colors.white,
                            backgroundColor: isButtonEnabled
                                ? const Color(0xff2666f6)
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed:
                              isButtonEnabled ? _handleButtonPress : null,
                          child: const Text("추가 하기",
                              style: TextStyle(fontSize: 20.0)),
                        )
                      : Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
