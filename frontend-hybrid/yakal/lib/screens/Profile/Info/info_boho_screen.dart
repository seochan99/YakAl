import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final TextEditingController _bohoNameController = TextEditingController();
  DateTime? _selectedBirthDate;

  @override
  void dispose() {
    _bohoNameController.dispose();
    super.dispose();
  }

  void _handleButtonPress() {
    final String guardianName = _bohoNameController.text;
    final DateTime? guardianBirthDate = _selectedBirthDate;

    widget.userViewModel.addOrUpdateGuardian(guardianName, guardianBirthDate);

    _bohoNameController.clear();
    setState(() {
      _selectedBirthDate = null;
    });

    Navigator.pop(context);
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
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
                      // 보호자가 있으면 보호자 이름, 생년월일 표시
                      // 보호자가 없으면 '등록된 보호자가 없습니다.' 표시
                      Text(
                        widget.userViewModel.user.value.guardian == null
                            ? '등록된 보호자가 없습니다.'
                            : '${widget.userViewModel.user.value.guardian!.name}님 (${widget.userViewModel.user.value.guardian!.birthDate})',
                      )
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
                  final isButtonEnabled =
                      value.text.isNotEmpty && _selectedBirthDate != null;

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
                    onPressed: isButtonEnabled ? _handleButtonPress : null,
                    child:
                        const Text("추가 하기", style: TextStyle(fontSize: 20.0)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
