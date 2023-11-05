import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:yakal/utilities/api/api.dart';
import 'package:yakal/widgets/Base/customized_back_app_bar.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'package:yakal/widgets/Base/my_bottom_navigation_bar.dart';
import 'package:yakal/widgets/Medication/medicine_add_cancel_dialog.dart';
import 'package:yakal/widgets/Setting/setting_mode_widget.dart';
import 'package:yakal/widgets/Setting/setting_time_selection_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomizedBackAppBar(
            title: "앱 설정",
            onPressed: () {
              final MyBottomNavigationBarController
                  mybottomNavigationBarController =
                  Get.put(MyBottomNavigationBarController(), permanent: true);
              mybottomNavigationBarController.changeTabIndex(1);
              Get.offAllNamed("/");
            }),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /* -------------- 모드 설정  -------------- */
              const Text("모드 설정",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 20),
              const SettingModeWidget(),
              const SizedBox(
                height: 64,
              ),
              /* -------------- 모드 설정  -------------- */
              const Text("시간 설정",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 16),
              const Text(
                "나의 루틴에 맞추어 시간을 조정할 수 있습니다.",
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff626272),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              const SettingTimeSelectionWidget(),
              /* -------------- 계정 설정  -------------- */
              const SizedBox(
                height: 64,
              ),
              const Text("계정 설정",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('로그아웃',
                    style: TextStyle(fontSize: 16, color: Color(0xff151515))),
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
                    builder: (BuildContext context) {
                      return MedicineAddCancelDialog(
                        question: "로그아웃 하시겠습니까?",
                        confirmLabel: "로그아웃",
                        cancelLabel: "아니요",
                        onConfirm: () async {
                          try {
                            Get.offAllNamed('/login');
                            // 카카오 로그아웃
                            await UserApi.instance.logout();
                            // 서버 로그아웃 호출
                            var dio = await authDioWithContext();
                            await dio.post('/auth/logout');
                          } catch (e) {
                            //error
                          }
                        },
                      );
                    },
                  );
                },
              ),
              // ListTile(
              //   contentPadding: EdgeInsets.zero,
              //   title: const Text('회원탈퇴',
              //       style: TextStyle(fontSize: 16, color: Color(0xff151515))),
              //   onTap: () {
              //     Get.toNamed('/signout');
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
