import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/LoginProcess/login_route.dart';
import 'package:yakal/screens/Login/LoginProcess/screen.dart';
import 'package:yakal/utilities/api/api.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Base/bottom_button.dart';

import 'style.dart';

class NicknameInputScreen extends StatefulWidget {
  final UserViewModel userViewModel = Get.find<UserViewModel>();
  final LoginRouteController routeController = Get.put(LoginRouteController());
  final NicknameInputLoadingController loadingController =
      Get.find<NicknameInputLoadingController>();

  static const int _usernameLimits = 5;

  NicknameInputScreen({super.key});

  @override
  State<NicknameInputScreen> createState() => _NicknameInputScreenState();
}

class _NicknameInputScreenState extends State<NicknameInputScreen> {
  late String _username;

  Future<void> _setNickname(BuildContext context) async {
    var dio = await authDio(context);

    widget.loadingController.setIsLoading(true);

    try {
      var response =
          await dio.patch("/user/name", data: {"nickname": _username});

      widget.userViewModel.updateNickName(_username);
    } on DioException catch (error) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('닉네임 설정에 실패했습니다.'),
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      widget.loadingController.setIsLoading(false);
    }
  }

  void _onTapNext() {
    _setNickname(context).then((value) {
      widget.routeController.goto(LoginRoute.modeSelection);
    });
  }

  @override
  void initState() {
    super.initState();

    _username = "";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                child: widget.loadingController.isLoading.value
                    ? ElevatedButton(
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
                          elevation: 0,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: ColorStyles.gray3,
                          ),
                        ),
                      )
                    : BottomButton(
                        "다음",
                        onPressed: _username.isEmpty ? null : _onTapNext,
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
    );
  }
}

class NicknameInputLoadingController extends GetxController {
  RxBool isLoading = false.obs;

  void setIsLoading(bool isLoading) {
    this.isLoading.value = isLoading;
  }
}
