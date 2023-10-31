import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/LoginProcess/login_route.dart';
import 'package:yakal/screens/Login/LoginProcess/screen.dart';
import 'package:yakal/utilities/api/api.dart';
import 'package:yakal/utilities/enum/mode.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Base/bottom_button.dart';
import 'package:yakal/widgets/Login/mode_selection_box.dart';

import 'style.dart';

class ModeSelectionScreen extends StatefulWidget {
  final UserViewModel userViewModel = Get.find<UserViewModel>();
  final LoginRouteController routeController = Get.find<LoginRouteController>();
  final ModeSelectionLoadingController loadingController =
      Get.find<ModeSelectionLoadingController>();

  ModeSelectionScreen({super.key});

  @override
  State<ModeSelectionScreen> createState() => _ModeSelectionScreenState();
}

class _ModeSelectionScreenState extends State<ModeSelectionScreen> {
  EMode _mode = EMode.NONE;

  Future<void> _setMode() async {
    var dio = await authDio(context);

    widget.loadingController.setIsLoading(true);

    try {
      var response = await dio
          .patch("/user/detail", data: {"isDetail": _mode == EMode.LITE});

      widget.userViewModel.updateMode(_mode == EMode.LITE);
      return;
    } on DioException catch (_) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('모드 설정에 실패했습니다.'),
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      widget.loadingController.setIsLoading(false);
    }
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
                    const Row(
                      children: [
                        Text(
                          "모드",
                          style: TextStyle(
                            color: ColorStyles.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          "를 선택해주세요",
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
                      height: 42.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _mode = EMode.NORMAL;
                              });
                            },
                            child: ModeSelectionBox(
                              backgroundColor: _mode == EMode.NORMAL
                                  ? ColorStyles.sub3
                                  : ColorStyles.white,
                              borderColor: _mode == EMode.NORMAL
                                  ? ColorStyles.sub1
                                  : ColorStyles.gray2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "일반모드",
                                    style: _mode == EMode.NORMAL
                                        ? ModeSelectionStyle.selectedModeTitle
                                        : ModeSelectionStyle.modeTitle,
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    "약알의 일반적인 모드입니다.",
                                    style: _mode == EMode.NORMAL
                                        ? ModeSelectionStyle
                                            .selectedModeDescription
                                        : ModeSelectionStyle.modeDescription,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _mode = EMode.LITE;
                              });
                            },
                            child: ModeSelectionBox(
                              backgroundColor: _mode == EMode.LITE
                                  ? ColorStyles.sub3
                                  : ColorStyles.white,
                              borderColor: _mode == EMode.LITE
                                  ? ColorStyles.sub1
                                  : ColorStyles.gray2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "라이트 모드",
                                    style: _mode == EMode.LITE
                                        ? ModeSelectionStyle.selectedModeTitle
                                        : ModeSelectionStyle.modeTitle,
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "시니어를 위한 쉬운 모드",
                                        style: _mode == EMode.LITE
                                            ? ModeSelectionStyle
                                                .selectedBoldModeDescription
                                            : ModeSelectionStyle
                                                .boldModeDescription,
                                      ),
                                      Text(
                                        "입니다.",
                                        style: _mode == EMode.LITE
                                            ? ModeSelectionStyle
                                                .selectedModeDescription
                                            : ModeSelectionStyle
                                                .modeDescription,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "다제약물 정보가 포함되어 있습니다.",
                                    style: _mode == EMode.LITE
                                        ? ModeSelectionStyle
                                            .selectedModeDescription
                                        : ModeSelectionStyle.modeDescription,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Obx(
                () => Expanded(
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
                          onPressed: _mode == EMode.NONE
                              ? null
                              : () {
                                  _setMode().then((value) {
                                    widget.routeController
                                        .goto(LoginRoute.finish);
                                  });
                                },
                          backgroundColor: _mode == EMode.NONE
                              ? ColorStyles.gray2
                              : ColorStyles.main,
                          color: _mode == EMode.NONE
                              ? ColorStyles.gray3
                              : ColorStyles.white,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ModeSelectionLoadingController extends GetxController {
  RxBool isLoading = false.obs;

  void setIsLoading(bool isLoading) {
    this.isLoading.value = isLoading;
  }
}
