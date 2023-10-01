import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/api/api.dart';

import '../../utilities/enum/login_process.dart';
import '../../utilities/style/color_styles.dart';
import '../../widgets/Login/back_confirm_dialog.dart';
import '../../widgets/Login/login_progress_bar.dart';

class EnterNicknameScreen extends StatefulWidget {
  static const int _usernameLimits = 5;

  const EnterNicknameScreen({super.key});

  @override
  State<EnterNicknameScreen> createState() => _EnterNicknameScreenState();
}

class _EnterNicknameScreenState extends State<EnterNicknameScreen> {
  bool _isLoading = false;
  bool _isError = false;
  String _username = "";
  final FocusNode textFocus = FocusNode();

  Future<bool> _setName(BuildContext context, String name) async {
    var dio = await authDio(context);
    var response = await dio.patch("/user/name", data: {"nickname": name});
    return response.statusCode == 200;
  }

  Future<void> Function() _onClickNext(BuildContext context) {
    return () async {
      setState(() {
        _isLoading = true;
      });

      var isSuccess = await _setName(context, _username);

      setState(() {
        _isLoading = false;
      });

      if (isSuccess) {
        Get.toNamed("/login/mode");
      } else {
        setState(() {
          _isError = true;
          _username = "";
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        textFocus.unfocus();

        if (_isError) {
          setState(() {
            _isError = false;
          });
        }
      },
      child: Container(
        color: ColorStyles.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ColorStyles.white,
            appBar: AppBar(
              title: LoginAppBar(
                progress: ELoginProcess.USERNAME,
                width: MediaQuery.of(context).size.width / 2.5,
                height: 8,
              ),
              backgroundColor: ColorStyles.white,
              automaticallyImplyLeading: true,
              leadingWidth: 90,
              leading: TextButton.icon(
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  foregroundColor: ColorStyles.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                icon: SvgPicture.asset("assets/icons/back.svg"),
                label: const Text(
                  "뒤로",
                  style: TextStyle(
                    color: ColorStyles.gray5,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
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
            ),
            body: Padding(
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
                              style: TextStyle(
                                color: ColorStyles.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                            const Row(
                              children: [
                                Text(
                                  "사용자 이름",
                                  style: TextStyle(
                                    color: ColorStyles.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    height: 1.4,
                                  ),
                                ),
                                Text(
                                  "을 입력해주세요.",
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
                              height: 40.0,
                            ),
                            const Text(
                              "사용자 이름",
                              style: TextStyle(
                                color: ColorStyles.gray4,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            TextField(
                              maxLength: EnterNicknameScreen._usernameLimits,
                              autofocus: true,
                              focusNode: textFocus,
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
                                    '${EnterNicknameScreen._usernameLimits}자 이내로 입력',
                                hintStyle: TextStyle(
                                  color: ColorStyles.gray3,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  height: 1.6,
                                ),
                                counterText: "",
                              ),
                              style: const TextStyle(
                                color: ColorStyles.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _username = value;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            _isError
                                ? const Text(
                                    "사용자 이름 설정에 실패했습니다.\n다시 시도해주세요.",
                                    style: TextStyle(
                                      color: ColorStyles.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      height: 1.6,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _isLoading
                            ? TextButton(
                                onPressed: null,
                                style: TextButton.styleFrom(
                                  backgroundColor: ColorStyles.gray2,
                                  splashFactory: NoSplash.splashFactory,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 18.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: ColorStyles.black,
                                  ),
                                ),
                              )
                            : TextButton(
                                onPressed: () {
                                  Get.toNamed("/login/mode");
                                },
                                // onPressed: _username.isEmpty
                                //     ? null
                                //     : _onClickNext(context),
                                style: TextButton.styleFrom(
                                  backgroundColor: _username.isEmpty
                                      ? ColorStyles.gray2
                                      : ColorStyles.main,
                                  splashFactory: NoSplash.splashFactory,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 18.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  "다음",
                                  style: TextStyle(
                                    color: _username.isEmpty
                                        ? ColorStyles.gray3
                                        : ColorStyles.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    height: 1,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
