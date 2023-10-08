import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/IdentificationResult/style.dart';
import 'package:yakal/widgets/Base/bottom_button.dart';
import 'package:yakal/widgets/Base/outer_frame.dart';

import '../../../utilities/api/api.dart';
import '../../../utilities/enum/login_process.dart';
import '../../../utilities/style/color_styles.dart';
import '../../../widgets/Base/back_confirm_dialog.dart';
import '../../../widgets/Login/login_app_bar.dart';

class IdentificationResultScreen extends StatelessWidget {
  const IdentificationResultScreen({super.key});

  Future<bool> _identify(BuildContext context, String impUid) async {
    var dio = await authDio(context);
    var response = await dio.patch("/user/identify", data: {"impUid": impUid});

    return response.statusCode == 200;
  }

  @override
  Widget build(BuildContext context) {
    return OuterFrame(
      outOfSafeAreaColor: ColorStyles.white,
      safeAreaColor: ColorStyles.white,
      appBar: LoginAppBar(
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
        progress: ELoginProcess.IDENTIFY,
      ),
      child: FutureBuilder<bool>(
        future: _identify(
          context,
          Get.arguments["imp_uid"],
        ),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            final isSuccess = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "본인인증",
                            style: IdentificationResultStyle.boldTitle,
                          ),
                          Text(
                            isSuccess ? "에 성공했습니다!" : "에 실패했습니다...",
                            style: IdentificationResultStyle.title,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              isSuccess
                                  ? "본인인증 과정이 완료되었습니다!\n가입까지 얼마 안 남았어요!"
                                  : "본인인증 과정에서 문제가 발생하였습니다.\n다시 시도해주시기 바랍니다.",
                              style: IdentificationResultStyle.description,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        isSuccess
                            ? "assets/icons/id-card.png"
                            : "assets/icons/failure.png",
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BottomButton(
                          snapshot.data! ? "다음" : "다시하기",
                          onPressed: isSuccess
                              ? () {
                                  Get.offNamed("/login/nickname");
                                }
                              : () {
                                  Get.until((Route route) =>
                                      Get.currentRoute ==
                                      "/login/identify/entry");
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
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorStyles.main,
              ),
            );
          }
        },
      ),
    );
  }
}
