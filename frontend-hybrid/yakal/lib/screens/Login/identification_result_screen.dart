import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/api/api.dart';

import '../../utilities/enum/login_process.dart';
import '../../utilities/style/color_styles.dart';
import '../../widgets/Login/back_confirm_dialog.dart';
import '../../widgets/Login/login_progress_bar.dart';

class IdentificationResultScreen extends StatelessWidget {
  const IdentificationResultScreen({super.key});

  Future<bool> _identify(BuildContext context, String impUid) async {
    var dio = await authDio(context);
    var response = await dio.patch("/user/identify", data: {"impUid": impUid});

    return response.statusCode == 200;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorStyles.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorStyles.white,
          appBar: AppBar(
            title: LoginProgressBar(
              progress: ELoginProcess.IDENTIFY,
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
                  fontFamily: "SUIT",
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
          body: _resultScreen(context, true),
          // 아래는 API 연결 후 적용
          // body: FutureBuilder<bool>(
          //   future: _identify(
          //     context,
          //     Get.arguments["impUid"],
          //   ),
          //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          //     if (snapshot.hasData) {
          //       return _resultScreen(context, snapshot.data!);
          //     } else {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //   },
          // ),
        ),
      ),
    );
  }
}

Widget _resultScreen(BuildContext context, bool isSuccess) {
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
                  style: TextStyle(
                    color: ColorStyles.black,
                    fontFamily: "SUIT",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                ),
                Text(
                  isSuccess ? "에 성공했습니다!" : "에 실패했습니다...",
                  style: const TextStyle(
                    color: ColorStyles.black,
                    fontFamily: "SUIT",
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
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
                    style: const TextStyle(
                      color: ColorStyles.gray5,
                      fontFamily: "SUIT",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                    ),
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
              child: TextButton(
                onPressed: isSuccess
                    ? () {
                        Get.toNamed("/login/nickname");
                      }
                    : () {
                        Get.back();
                        Get.back();
                      },
                style: TextButton.styleFrom(
                  backgroundColor: ColorStyles.main,
                  splashFactory: NoSplash.splashFactory,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  isSuccess ? "다음" : "다시하기",
                  style: const TextStyle(
                    color: ColorStyles.white,
                    fontFamily: "SUIT",
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
  );
}
