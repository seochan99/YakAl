import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../utilities/style/color_styles.dart';

class InfoHospitalScreen extends StatelessWidget {
  const InfoHospitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '병원 기록 추가',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '보호자 정보',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 16),
                Text(
                  '보호자 정보를 입력해주세요.\n',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                // InfoBohoList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
