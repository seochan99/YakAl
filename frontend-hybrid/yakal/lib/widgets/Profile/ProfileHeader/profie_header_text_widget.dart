import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Base/input_horizontal_text_field_widget.dart';

class ProfileHeaderText extends StatefulWidget {
  static const int _usernameLimits = 5;
  const ProfileHeaderText({
    super.key,
    required this.userViewModel,
  });

  final UserViewModel userViewModel;

  @override
  _ProfileHeaderTextState createState() => _ProfileHeaderTextState();
}

class _ProfileHeaderTextState extends State<ProfileHeaderText> {
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
    widget.userViewModel.updateNickName(newNickName);
    _nickNameController.clear(); // Clear the text field
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 프로필 사진
        Obx(
          () => RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.userViewModel.user.value.nickName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(8, 8, 8, 1.0),
                  ),
                ),
                const TextSpan(
                  text: "님,\n약알과 함께 건강하세요!",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(8, 8, 8, 1.0),
                  ),
                ),
              ],
            ),
          ),
        ),

        const Spacer(),

        // 수정 버튼
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            foregroundColor: Colors.black,
            backgroundColor: const Color.fromRGBO(233, 233, 238, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: const BorderSide(
              color: Color.fromRGBO(233, 233, 238, 1),
            ),
          ),
          onPressed: () {
            double screenHeight = MediaQuery.of(context).size.height;
            // 70% of screen height
            double targetHeight = 0.7 * screenHeight;
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: targetHeight,
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
                        Row(
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '닉네임 수정',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  '약알이 어떻게 불러드릴까요?',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            const Spacer(),
                            // X버튼 아이콘 누르면 sheet 닫힘
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),

                        // text input box
                        const SizedBox(height: 20),
                        InputHorizontalTextFieldWidget(
                          nickNameController: _nickNameController,
                          title: '닉네임',
                        ),

                        const SizedBox(height: 20),

                        ValueListenableBuilder<TextEditingValue>(
                          valueListenable: _nickNameController,
                          builder: (context, value, child) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                foregroundColor: Colors.white,
                                backgroundColor: const Color(0xff2666f6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: value.text.isNotEmpty
                                  ? _handleButtonPress
                                  : null,
                              child: const Text("완료",
                                  style: TextStyle(fontSize: 20.0)),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Text(
            '수정',
            style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(144, 144, 159, 1),
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
