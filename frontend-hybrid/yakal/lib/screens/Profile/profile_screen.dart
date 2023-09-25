import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Profile/profie_header_widget.dart'; // Import the AuthLoginScreen

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
          Container(
            color: Colors.white,
            // height 240px
            height: 240,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  ProfileHeader(userViewModel: userViewModel),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // 닉네임 수정 모달 띄우기
                      // showEditNicknameModal = true;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.edit),
                          Text('닉네임 수정'),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ROW BACCK GORUND WHITE
          ),
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
