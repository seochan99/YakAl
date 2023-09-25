import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart'; // Import the AuthLoginScreen

// 임시 유저 클래스

class ProfileScreen extends StatelessWidget {
  final bool showEditNicknameModal = false;
  final UserViewModel userViewModel = Get.put(UserViewModel());

  EdgeInsets sideMargin = const EdgeInsets.symmetric(horizontal: 20);
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
                  Row(
                    children: [
                      Text(
                          "${userViewModel.user.value.nickName}님,\n약알과 함께 건강하세요!"),
                      const Spacer(),
                      // 닉네임 수정 네모 버튼 안에는 수정 이라고 글자 적혀있다.
                      GestureDetector(
                        onTap: () {
                          // 닉네임 수정 모달 띄우기
                          // showEditNicknameModal = true;
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: const Center(
                            child: Text('수정'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // 닉네임 수정 모달 띄우기
                      // showEditNicknameModal = true;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: const Center(
                        child: Text("전문가에게 복약정보 공유"),
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
