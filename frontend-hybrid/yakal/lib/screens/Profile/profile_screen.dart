import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Profile/ProfileHeader/profile_header_widget.dart';
import 'package:yakal/widgets/Profile/profile_test_button_widget.dart';
// 임시 유저 클래스

class ProfileScreen extends StatelessWidget {
  final bool showEditNicknameModal = false;
  final UserViewModel userViewModel = Get.put(UserViewModel());

  final EdgeInsets sideMargin = const EdgeInsets.symmetric(horizontal: 20);

  ProfileScreen({super.key});

  // test normal preesed function go test1 page
  void testNormalPressed() {
    Get.toNamed("/noamalTest");
  }

  void testSeniorPressed() {
    Get.toNamed("/seniorTest");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 프로필 헤더
            ProfileHeader(userViewModel: userViewModel),
            // 구분선
            Container(
                // width 꽉 차게
                width: double.infinity,
                height: 2,
                decoration: const BoxDecoration(color: Color(0xffe9e9ee))),

            const SizedBox(height: 26),
            // 아이콘 + text : 아이콘 "자가 진단 테스트"
            Padding(
              padding: sideMargin,
              child: Column(
                children: [
                  Row(
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
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ProfileTestButtonWidget(
                            // function
                            boldText: "일반",
                            normalText: " (65세 미만)",
                            testPressed: testNormalPressed,
                            btnColor: const Color(0xff5588FD)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ProfileTestButtonWidget(
                            // function
                            boldText: "시니어",
                            normalText: " (65세 이상)",
                            testPressed: testNormalPressed,
                            btnColor: const Color(0xff2666F6)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // 보호자, 병원기록, 특이사항 둥근 버튼
            // 흰색 배경 박스
            // Row
            Container(
              color: Colors.white,
              // top 24 bottom 26 padding
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoIconBtnWidget(
                    iconImg: 'assets/icons/icon-mypage-protector.svg',
                    text: '보호자',
                  ),
                  InfoIconBtnWidget(
                    iconImg: 'assets/icons/icon-mypage-hospital.svg',
                    text: '병원 기록',
                  ),
                  InfoIconBtnWidget(
                    iconImg: 'assets/icons/icon-mypage-special.svg',
                    text: '특이사항',
                  )
                ],
              ),
            ),
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
      ),
    );
  }
}

class InfoIconBtnWidget extends StatelessWidget {
  final String iconImg;
  final String text;

  const InfoIconBtnWidget({
    Key? key,
    required this.iconImg,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // icon button
        IconButton(
          onPressed: () {
            Get.toNamed("/login");
          },
          icon: SvgPicture.asset(
            iconImg,
            width: 50,
            height: 50,
          ),
        ),
        Text(text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xff151515),
            ))
      ],
    );
  }
}
