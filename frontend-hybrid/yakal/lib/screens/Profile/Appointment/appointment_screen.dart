import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/appointment_controller.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'package:yakal/widgets/Base/input_horizontal_text_field_widget.dart';

class AppointmentScreen extends StatefulWidget {
  // viewmodel가져오기
  // final UserViewModel userViewModel = Get.put(UserViewModel());

  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String expertName = '';
  String expertBirthDate = '';
  int expertId = 0;
  bool isSelectedExpert = false;
  bool isSelectedSearch = false;

  final TextEditingController _expertNameController = TextEditingController();
  final AppointmentController appointmentController =
      Get.put(AppointmentController());

  @override
  void dispose() {
    _expertNameController.dispose();
    super.dispose();
  }

// 추가하기 버튼 클릭시
  void _handleButtonPress() {
    Get.snackbar(
      '전문가 정보 추가',
      '전문가 정보 추가 완료(새로 추가시 업데이트 됩니다!)',
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      duration: const Duration(seconds: 2, microseconds: 500),
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorStyles.gray1,
      colorText: Colors.black,
    );
    appointmentController.postExperts(expertId, expertName, expertBirthDate);
    _expertNameController.clear();
    setState(() {});
    // Navigator.pop(context);
  }

// 검색하기 버튼 클릭시
  void _handleButtonPress2() async {
    // 검색완료
    Get.snackbar(
      '전문가 검색',
      '전문가 검색 완료(전문가 이름을 정확히 입력해주셔야 해요!)',
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      duration: const Duration(seconds: 2, microseconds: 500),
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorStyles.gray1,
      colorText: Colors.black,
    );
    final String expertName = _expertNameController.text;

    // expert 가져오기
    await appointmentController.getExperts(expertName);

    setState(() {
      _expertNameController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: "전문가 검색"),
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
                        '전문가 성함',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 16),
                      InputHorizontalTextFieldWidget(
                        nickNameController: _expertNameController,
                        title: '전문가 성함',
                      ),
                      // 등록된 전문가
                      const SizedBox(height: 24),
                      const Text(
                        '등록된 전문가',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 16),
                      Obx(() {
                        return Text(
                          appointmentController.myExperts.isEmpty
                              ? '등록된 전문가가 없습니다.'
                              : '${appointmentController.myExperts[0].name}님',
                        );
                      }),
                      const SizedBox(height: 24),
                      const Text(
                        '전문가를 선택해주세요!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 16),
                      // 검색 결과로 나오는 전문가

                      Obx(() {
                        return appointmentController.epxerts.isEmpty
                            ? const Text('검색된 전문가가 없습니다.')
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: appointmentController.epxerts.length,
                                itemBuilder: (context, index) {
                                  final expert =
                                      appointmentController.epxerts[index];
                                  return Card(
                                    color: expert.id == expertId
                                        ? Colors.blue.withOpacity(0.3)
                                        : null, // 선택한 항목의 id와 현재 항목의 id를 비교
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          expertName = expert.name;
                                          expertBirthDate = expert.birthDate;
                                          expertId = expert.id;
                                          isSelectedExpert = true;
                                        });
                                      },
                                      highlightColor:
                                          Colors.blue.withOpacity(0.3),
                                      child: ListTile(
                                        title: Text(expert.name),
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
                valueListenable: _expertNameController,
                builder: (context, value, child) {
                  final isButtonEnabled =
                      value.text.isNotEmpty && !isSelectedExpert;
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
                valueListenable: _expertNameController,
                builder: (context, value, child) {
                  final isButtonEnabled = isSelectedExpert;
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
