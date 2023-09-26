import 'package:flutter/material.dart';
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

          Obx(() {
            return Text('Nickname: ${userViewModel.user.value.nickName}');
          }),
          Obx(() {
            return Text('Test Count: ${userViewModel.user.value.testCnt}');
          }),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                Get.toNamed("/login");
              },
              child: const Text('로그인')),

          // 닉네임 변경

          ElevatedButton(
            onPressed: () {
              userViewModel.updateNickName('New Nickname');
            },
            child: const Text('Change Nickname'),
          ),
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
