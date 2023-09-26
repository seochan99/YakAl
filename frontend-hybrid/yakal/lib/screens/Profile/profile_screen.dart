import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Profile/ProfileHeader/profile_header_widget.dart';
// 임시 유저 클래스

class ProfileScreen extends StatelessWidget {
  final bool showEditNicknameModal = false;
  final UserViewModel userViewModel = Get.put(UserViewModel());

  final EdgeInsets sideMargin = const EdgeInsets.symmetric(horizontal: 20);

  ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 프로필 헤더
          ProfileHeader(userViewModel: userViewModel),
          Container(
              // width 꽉 차게
              width: double.infinity,
              height: 2,
              decoration: const BoxDecoration(color: Color(0xffe9e9ee))),

          const SizedBox(height: 26),
          // 아이콘 + text : 아이콘 "자가 진단 테스트"
          Padding(
            padding: sideMargin,
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/circle-emphasis.svg',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 10),
                const Text(
                  '자가 진단 테스트',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff454545),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),
          // row 둥근 사각형 버튼 두개

          // Obx(() {
          //   return Text('Nickname: ${userViewModel.user.value.nickName}');
          // }),
          // Obx(() {
          //   return Text('Test Count: ${userViewModel.user.value.testCnt}');
          // }),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                Get.toNamed("/login");
              },
              child: const Text('로그인')),

          // 닉네임 변경
          // test 올리기
          ElevatedButton(
            onPressed: () {
              userViewModel.incrementTestCount();
            },
            child: const Text('Increment Test Count'),
          ),
        ],
      ),
    );
  }
}
