import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yakal/screens/Login/LoginProcess/LoginTerms/TermsDetail/style.dart';
import 'package:yakal/screens/Profile/Appointment/appointment_screen.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/mingam_controller.dart';
import 'package:yakal/widgets/Base/outer_frame.dart';

class MingamDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  const MingamDetailScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final MingamController mingamController = Get.put(MingamController());
    return OuterFrame(
      outOfSafeAreaColor: ColorStyles.white,
      safeAreaColor: ColorStyles.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          title: Text(
            title,
            style: TermsDetailStyle.title,
          ),
          surfaceTintColor: Colors.white,
          centerTitle: true,
          backgroundColor: ColorStyles.white,
          automaticallyImplyLeading: true,
          leadingWidth: 72,
          leading: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            child: GestureDetector(
              child: SvgPicture.asset(
                "assets/icons/x-mark.svg",
              ),
              onTap: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              // 여기에 Expanded 위젯을 추가합니다.
              child: SingleChildScrollView(
                child: Text(
                  content,
                  style: TermsDetailStyle.content,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff2666f6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                // 바꾸기
                mingamController.setMingamStatus(true);
                // 이동
                Get.off(() => AppointmentScreen());
              },
              child: const Text("동의", style: TextStyle(fontSize: 20.0)),
            ),
          ],
        ),
      ),
    );
  }
}
