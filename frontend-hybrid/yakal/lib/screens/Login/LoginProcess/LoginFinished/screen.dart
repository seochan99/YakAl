import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Base/bottom_button.dart';

import 'style.dart';

class LoginFinishedScreen extends StatelessWidget {
  const LoginFinishedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Get.put(UserViewModel(), permanent: true);

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
                    Row(
                      children: [
                        Obx(
                          () {
                            return Text(
                              userViewModel.user.value.nickName,
                              style: LoginFinishedStyle.name,
                            );
                          },
                        ),
                        const Text(
                          "님,",
                          style: LoginFinishedStyle.title,
                        ),
                      ],
                    ),
                    const Text(
                      "회원가입이 완료되었습니다!",
                      style: LoginFinishedStyle.title,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/logo.png",
                width: MediaQuery.of(context).size.width * 0.55,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: BottomButton(
                  "메인으로",
                  onPressed: () {
                    Get.toNamed("/");
                  },
                  backgroundColor: ColorStyles.main,
                  color: ColorStyles.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
