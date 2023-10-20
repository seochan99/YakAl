import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Base/my_bottom_navigation_bar.dart';
import 'package:yakal/widgets/Profile/ProfileHeader/profile_header_widget.dart';
import 'package:yakal/widgets/Profile/profile_info_icon_btn_widget.dart';
import 'package:yakal/widgets/Profile/profile_setting_row_box_widget.dart';
import 'package:yakal/widgets/Profile/profile_setting_row_btn_widget.dart';
import 'package:yakal/widgets/Profile/profile_test_button_widget.dart';
// 임시 유저 클래스

class ProfileScreen extends StatelessWidget {
  final bool showEditNicknameModal = false;
  final UserViewModel userViewModel = Get.put(UserViewModel());

  final EdgeInsets sideMargin = const EdgeInsets.symmetric(horizontal: 20);

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<UserViewModel>(
              init: userViewModel,
              initState: (_) {
                userViewModel
                    .fetchUserData(); // Fetch user data when entering the screen
              },
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /* ----------------- 프로필 헤더 뷰 -----------------  */
                    ProfileHeader(userViewModel: userViewModel),
                    /* ----------------- 구분선 -----------------  */
                    Container(
                        // width 꽉 차게
                        width: double.infinity,
                        height: 2,
                        decoration:
                            const BoxDecoration(color: Color(0xffe9e9ee))),
                    const SizedBox(height: 26),
                    /* ----------------- 자가 진단 테스트 뷰 -----------------  */
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
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ProfileTestButtonWidget(
                                    // function
                                    boldText: "일반",
                                    normalText: " (65세 미만)",
                                    btnColor: Color(0xff5588FD)),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: ProfileTestButtonWidget(
                                    // function
                                    boldText: "시니어",
                                    normalText: " (65세 이상)",
                                    btnColor: Color(0xff2666F6)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    /* ----------------- 보호자, 병원기록, 특이사항 3개 버튼 뷰 -----------------  */
                    Container(
                      color: Colors.white,
                      // top 24 bottom 26 padding
                      // padding: const EdgeInsets.symmetric(vertical: 24),
                      child: const Row(
                        children: [
                          Expanded(
                            child: ProfileInfoIconBtnWidget(
                              goPage: "/profile/boho",
                              iconImg: 'assets/icons/icon-mypage-protector.svg',
                              text: '보호자',
                            ),
                          ),
                          Expanded(
                            child: ProfileInfoIconBtnWidget(
                              goPage: "/profile/hospital",
                              iconImg: 'assets/icons/icon-mypage-hospital.svg',
                              text: '병원 기록',
                            ),
                          ),
                          Expanded(
                            child: ProfileInfoIconBtnWidget(
                              goPage: "/profile/star",
                              iconImg: 'assets/icons/icon-mypage-special.svg',
                              text: '특이사항',
                            ),
                          )
                        ],
                      ),
                    ),

                    /* ----------------- setting List View -----------------  */
                    const SizedBox(height: 8),
                    const ProfileSettingRowBtnWidget(
                        iconImg: 'assets/icons/icon-setting.svg',
                        text: '앱 설정',
                        routeLinkText: "/setting/app"),
                    const ProfileSettingRowBtnWidget(
                        iconImg: 'assets/icons/icon-line-bell.svg',
                        text: '알림 설정',
                        routeLinkText: "/setting/alert"),
                    /* ----------------- 위치 나중에 -----------------  */
                    // const ProfileSettingRowBtnWidget(
                    //   iconImg: 'assets/icons/icon-location.svg',
                    //   text: '내 위치 설정',
                    // )
                    const SizedBox(height: 8),
                    const ProfileSettingRowBoxWidget(
                        text: '약알에게 바라는 점', routerLinkText: "/profile/wish"),
                    const ProfileSettingRowBoxWidget(
                        text: '버전 정보', routerLinkText: null),
                    const SizedBox(height: 8),
                    const ProfileSettingRowBoxWidget(
                        text: '전문가 인증', routerLinkText: "/wishList"),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
