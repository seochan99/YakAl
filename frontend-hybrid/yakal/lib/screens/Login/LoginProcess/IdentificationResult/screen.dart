import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/LoginProcess/IdentificationResult/style.dart';
import 'package:yakal/screens/Login/LoginProcess/login_route.dart';
import 'package:yakal/screens/Login/LoginProcess/screen.dart';
import 'package:yakal/utilities/api/api.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/bottom_button.dart';

class IdentificationResultScreen extends StatelessWidget {
  const IdentificationResultScreen({super.key});

  Future<bool> _identify(BuildContext context, String impUid) async {
    var dio = await authDio(context);

    try {
      var response =
          await dio.patch("/user/identify", data: {"impUid": impUid});
      return response.statusCode == 200;
    } on DioException catch (error) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
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
                                final routeController =
                                    Get.put(LoginRouteController());
                                routeController.goto(LoginRoute.nicknameInput);
                              }
                            : () {
                                final routeController =
                                    Get.put(LoginRouteController());
                                routeController.goto(LoginRoute.identifyEntry);
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
    );
  }
}
