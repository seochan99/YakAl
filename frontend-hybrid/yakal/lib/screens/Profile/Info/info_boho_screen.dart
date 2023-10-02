import 'package:flutter/material.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'package:yakal/widgets/Base/input_horizontal_text_field_widget.dart';

class InfoBohoScreen extends StatefulWidget {
  const InfoBohoScreen({super.key});

  @override
  State<InfoBohoScreen> createState() => _InfoBohoScreenState();
}

class _InfoBohoScreenState extends State<InfoBohoScreen> {
  final FocusNode textFocus = FocusNode();
  final TextEditingController _nickNameController = TextEditingController();

  @override
  void dispose() {
    _nickNameController.dispose();
    super.dispose();
  }

  //  닉네임 변경
  _handleButtonPress() {
    // no nickname
    if (_nickNameController.text.isEmpty) {
      return;
    }
    String newNickName = _nickNameController.text;
    // widget.userViewModel.updateNickName(newNickName);
    _nickNameController.clear(); // Clear the text field
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: "보호자 정보"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '보호자 성함',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                // Input field for 보호자 성함
                InputHorizontalTextFieldWidget(
                  nickNameController: _nickNameController,
                ),
                const SizedBox(height: 16),

                const Text(
                  '보호자 생년월일',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                // DatePicker for 보호자 생년월일
                InkWell(
                  onTap: () {
                    // Implement a DatePicker and handle the selected date
                  },
                  child: Container(
                      // Style this container to represent the DatePicker UI
                      // You can show the selected date inside this container
                      ),
                ),

                // Add the 완료버튼 here, enable it when both fields are filled
                ValueListenableBuilder<TextEditingValue>(
                  // Listen to the text editing for both fields
                  valueListenable:
                      _nickNameController, // You might need another controller for the 보호자 성함
                  builder: (context, value, child) {
                    // Enable the button when both fields are filled
                    final isButtonEnabled = value.text
                        .isNotEmpty; // Adjust this based on your conditions

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
                      child: const Text("완료", style: TextStyle(fontSize: 20.0)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
