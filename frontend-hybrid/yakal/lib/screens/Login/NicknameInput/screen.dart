import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/NicknameInput/style.dart';
import 'package:yakal/widgets/Base/bottom_button.dart';
import 'package:yakal/widgets/Login/outer_frame.dart';

import '../../../utilities/enum/login_process.dart';
import '../../../utilities/style/color_styles.dart';
import '../../../widgets/Login/back_confirm_dialog.dart';
import '../../../widgets/Login/login_app_bar.dart';

class NicknameInputScreen extends StatefulWidget {
  static const int _usernameLimits = 5;

  const NicknameInputScreen({super.key});

  @override
  State<NicknameInputScreen> createState() => _NicknameInputScreenState();
}

class _NicknameInputScreenState extends State<NicknameInputScreen> {
  String _username = "";
  final FocusNode _textFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _textFocus.unfocus();
      },
      child: OuterFrame(
        outOfSafeAreaColor: ColorStyles.white,
        safeAreaColor: ColorStyles.white,
        appBar: LoginAppBar(
          progress: ELoginProcess.USERNAME,
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
              builder: (BuildContext context) {
                return const BackConfirmDialog(
                  question: "본인인증을 다시 하시겠습니까?",
                  backTo: "/login/identify/entry",
                );
              },
            );
          },
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "약알에서 사용할",
                          style: NicknameInputStyle.title,
                        ),
                        const Row(
                          children: [
                            Text(
                              "닉네임",
                              style: NicknameInputStyle.boldTitle,
                            ),
                            Text(
                              "을 입력해주세요.",
                              style: NicknameInputStyle.title,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        const Text(
                          "닉네임",
                          style: NicknameInputStyle.label,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          maxLength: NicknameInputScreen._usernameLimits,
                          autofocus: true,
                          focusNode: _textFocus,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(20.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide(
                                color: ColorStyles.gray2,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide(
                                color: ColorStyles.sub1,
                                width: 2.0,
                              ),
                            ),
                            hintText:
                                '${NicknameInputScreen._usernameLimits}자 이내로 입력',
                            hintStyle: NicknameInputStyle.inputHint,
                            counterText: "",
                          ),
                          style: NicknameInputStyle.input,
                          onChanged: (value) {
                            setState(() {
                              _username = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: BottomButton(
                      "다음",
                      onPressed: _username.isEmpty
                          ? null
                          : () {
                              Get.toNamed(
                                "/login/nickname/process",
                                arguments: _username,
                              );
                            },
                      backgroundColor: _username.isEmpty
                          ? ColorStyles.gray2
                          : ColorStyles.main,
                      color: _username.isEmpty
                          ? ColorStyles.gray3
                          : ColorStyles.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
