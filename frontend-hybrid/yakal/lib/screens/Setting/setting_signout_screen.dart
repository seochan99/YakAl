import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingSignoutScreen extends StatelessWidget {
  const SettingSignoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // color

      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('회원 탈퇴'),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          // white background

          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: SvgPicture.asset(
                  'assets/icons/icon-morning.svg',
                  width: 56,
                  height: 56,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  '정말 탈퇴 하시겠어요?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xff151515),
                  ),
                ),
              ),
              const SizedBox(height: 76),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  border: null,
                  // #background
                  color: const Color(0xffF7F7F7),

                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '※ 탈퇴시 유의사항',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '· 약알 앱 진행 중일 경우(인앱 결제 등) 탈퇴가 불가합니다.\n\n'
                      '· 댓글, 좋아요, 내가 쓴 글 등 기타 아이디와 연계된 모든 정보를 삭제합니다.\n\n'
                      '· 탈퇴한 회원은 60일동안 해당 아이디 기준으로 재가입이 불가하고 일정기간 동안 재가입 및 동일 아이디 사용이 불가합니다.\n\n'
                      '· 회원 탈퇴 일로부터 닉네임을 포함한 계정 정보(아이디/휴대폰 번호/ 등록된 카드 등)는 \'개인 정보 보호 정책\'에 따라 60일간 보관되며, 60일이 경과한 후에는 모든 개인정보는 완전히 삭제되며 더 이상 복구할 수 없습니다.',
                      style: TextStyle(
                        color: Color(0xff151515),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: const Color(0xffE9E9EE),
                        foregroundColor: const Color(0xff626272),
                      ),
                      child: const Center(
                          child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('취소',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                      )),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: const Color(0xffFF6F6F),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // Handle 탈퇴하기 button press
                      },
                      child: const Center(
                          child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('탈퇴하기',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                      )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
