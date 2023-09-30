import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Auth/terms_detail_screen.dart';
import 'package:yakal/utilities/enum/login_process.dart';
import 'package:yakal/widgets/Auth/auth_check_button.dart';
import 'package:yakal/widgets/Auth/back_confirm_dialog.dart';
import 'package:yakal/widgets/Auth/login_progress_bar.dart';

import '../../utilities/style/color_styles.dart';

class LoginTermsScreen extends StatelessWidget {
  static const List<Map<String, Object>> terms = [
    {
      "isRequired": true,
      "title": "서비스 이용약관",
      "content": """
1. 개인정보의 수집 및 이용 동의서
- 이용자가 제공한 모든 정보는 다음의 목적을 위해 활용 하며, 하기 목적 이외의 용도로는 사용되지 않습니다.

① 개인정보 수집 항목 및 수집• 이용 목적
가) 수집 항목 (필수항목)
- 성명(국문), 주민등록번호, 주소, 전화번호(자택, 휴대전 화), 사진, 이메일, 나이. 재학정보, 병역사항, 외국어 점수, 가족관계, 재산정도, 수상내역, 사회활동, 타 장학금 수혜현황, 요식업 종사 현황 등 지원 신청서에 기재된 정보 또는 신청자가 제공한 정보 나) 수집 및 이용 목적

② 개인정보 보유 및 이용기간
- 수집• 이용 동의일로부터 개인정보의 수집 • 이용목적을 달성할 때까지

③ 동의거부관리
- 귀하께서는 본 안내에 따른 개인정보 수집, 이용에 대하 여 동의를 거부하실 권리가 있습니다. 다만, 귀하가 개인정보의 수집/이용에 동의를 거부하시는 경우 에 장학생 선발 과정에 있어 불이익이 발생할 수 있음을 알려드립니다.
      """,
    },
    {
      "isRequired": true,
      "title": "위치기반 서비스 이용약관 동의",
      "content": """
1. 개인정보의 수집 및 이용 동의서
- 이용자가 제공한 모든 정보는 다음의 목적을 위해 활용 하며, 하기 목적 이외의 용도로는 사용되지 않습니다.

① 개인정보 수집 항목 및 수집• 이용 목적
가) 수집 항목 (필수항목)
- 성명(국문), 주민등록번호, 주소, 전화번호(자택, 휴대전 화), 사진, 이메일, 나이. 재학정보, 병역사항, 외국어 점수, 가족관계, 재산정도, 수상내역, 사회활동, 타 장학금 수혜현황, 요식업 종사 현황 등 지원 신청서에 기재된 정보 또는 신청자가 제공한 정보 나) 수집 및 이용 목적

② 개인정보 보유 및 이용기간
- 수집• 이용 동의일로부터 개인정보의 수집 • 이용목적을 달성할 때까지

③ 동의거부관리
- 귀하께서는 본 안내에 따른 개인정보 수집, 이용에 대하 여 동의를 거부하실 권리가 있습니다. 다만, 귀하가 개인정보의 수집/이용에 동의를 거부하시는 경우 에 장학생 선발 과정에 있어 불이익이 발생할 수 있음을 알려드립니다.
      """,
    },
    {
      "isRequired": true,
      "title": "개인정보 수집 및 이용 동의",
      "content": """
1. 개인정보의 수집 및 이용 동의서
- 이용자가 제공한 모든 정보는 다음의 목적을 위해 활용 하며, 하기 목적 이외의 용도로는 사용되지 않습니다.

① 개인정보 수집 항목 및 수집• 이용 목적
가) 수집 항목 (필수항목)
- 성명(국문), 주민등록번호, 주소, 전화번호(자택, 휴대전 화), 사진, 이메일, 나이. 재학정보, 병역사항, 외국어 점수, 가족관계, 재산정도, 수상내역, 사회활동, 타 장학금 수혜현황, 요식업 종사 현황 등 지원 신청서에 기재된 정보 또는 신청자가 제공한 정보 나) 수집 및 이용 목적

② 개인정보 보유 및 이용기간
- 수집• 이용 동의일로부터 개인정보의 수집 • 이용목적을 달성할 때까지

③ 동의거부관리
- 귀하께서는 본 안내에 따른 개인정보 수집, 이용에 대하 여 동의를 거부하실 권리가 있습니다. 다만, 귀하가 개인정보의 수집/이용에 동의를 거부하시는 경우 에 장학생 선발 과정에 있어 불이익이 발생할 수 있음을 알려드립니다.
      """,
    },
    {
      "isRequired": false,
      "title": "마케팅 정보 활용 동의",
      "content": """
1. 개인정보의 수집 및 이용 동의서
- 이용자가 제공한 모든 정보는 다음의 목적을 위해 활용 하며, 하기 목적 이외의 용도로는 사용되지 않습니다.

① 개인정보 수집 항목 및 수집• 이용 목적
가) 수집 항목 (필수항목)
- 성명(국문), 주민등록번호, 주소, 전화번호(자택, 휴대전 화), 사진, 이메일, 나이. 재학정보, 병역사항, 외국어 점수, 가족관계, 재산정도, 수상내역, 사회활동, 타 장학금 수혜현황, 요식업 종사 현황 등 지원 신청서에 기재된 정보 또는 신청자가 제공한 정보 나) 수집 및 이용 목적

② 개인정보 보유 및 이용기간
- 수집• 이용 동의일로부터 개인정보의 수집 • 이용목적을 달성할 때까지

③ 동의거부관리
- 귀하께서는 본 안내에 따른 개인정보 수집, 이용에 대하 여 동의를 거부하실 권리가 있습니다. 다만, 귀하가 개인정보의 수집/이용에 동의를 거부하시는 경우 에 장학생 선발 과정에 있어 불이익이 발생할 수 있음을 알려드립니다.
      """,
    },
  ];

  const LoginTermsScreen({super.key});

  void _showTermsDialog(BuildContext context, Widget termsScreen) {
    showGeneralDialog(
      barrierDismissible: false,
      context: context,
      transitionDuration: const Duration(
        milliseconds: 250,
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: const Offset(0.0, 0.0),
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return termsScreen;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TermsCheckedController());

    return Container(
      color: ColorStyles.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorStyles.white,
          appBar: AppBar(
            title: LoginProgressBar(
              progress: ELoginProcess.TERMS,
              width: MediaQuery.of(context).size.width / 2.5,
              height: 8,
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
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
                  builder: (BuildContext context) {
                    return const BackConfirmDialog(
                      question: "다시 로그인하시겠습니까?",
                    );
                  },
                );
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 32.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        Text(
                          "약관",
                          style: TextStyle(
                            color: ColorStyles.black,
                            fontFamily: "SUIT",
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          "을 확인해주세요",
                          style: TextStyle(
                            color: ColorStyles.black,
                            fontFamily: "SUIT",
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 72,
                    ),
                    Row(
                      children: [
                        Obx(
                          () {
                            return AuthCheckButton(
                              isChecked: controller.isCheckedAll(),
                              onPressed: controller.toggleAll,
                            );
                          },
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        const Text(
                          "전체 동의",
                          style: TextStyle(
                            color: ColorStyles.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.685,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ...List.generate(
                      terms.length,
                      (index) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Obx(
                                    () {
                                      return AuthCheckButton(
                                        isChecked: controller.isChecked[index],
                                        onPressed: controller.toggle(index),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    "(${terms[index]["isRequired"] as bool ? "필수" : "선택"})",
                                    style: TextStyle(
                                      color: (terms[index]["isRequired"] as bool
                                          ? ColorStyles.black
                                          : ColorStyles.sub1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      height: 1.685,
                                    ),
                                  ),
                                  Text(
                                    " ${terms[index]["title"] as String}",
                                    style: const TextStyle(
                                      color: ColorStyles.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      height: 1.685,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showTermsDialog(
                                    context,
                                    TermsDetailScreen(
                                      title: terms[index]["title"] as String,
                                      content:
                                          terms[index]["content"] as String,
                                    ),
                                  );
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/next.svg",
                                  width: 8,
                                  height: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () {
                          return TextButton(
                            onPressed: controller.isCheckedAll()
                                ? () {
                                    Get.toNamed("/login/identify/entry");
                                  }
                                : null,
                            style: TextButton.styleFrom(
                              backgroundColor: controller.isCheckedAll()
                                  ? ColorStyles.main
                                  : ColorStyles.gray2,
                              splashFactory: NoSplash.splashFactory,
                              padding: const EdgeInsets.symmetric(
                                vertical: 18.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              "다음",
                              style: TextStyle(
                                color: controller.isCheckedAll()
                                    ? ColorStyles.white
                                    : ColorStyles.gray3,
                                fontFamily: "SUIT",
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TermsCheckedController extends GetxController {
  final RxList<bool> isChecked = <bool>[false, false, false, false].obs;

  void setAll(bool checked) {
    isChecked([
      checked,
      checked,
      checked,
      checked,
    ]);
  }

  void toggleAll() {
    if (isCheckedAll()) {
      setAll(false);
    } else {
      setAll(true);
    }
  }

  void Function() toggle(int index) {
    return () => isChecked[index] = !isChecked[index];
  }

  bool isCheckedAll() {
    return isChecked[0] && isChecked[1] && isChecked[2] && isChecked[3];
  }
}
