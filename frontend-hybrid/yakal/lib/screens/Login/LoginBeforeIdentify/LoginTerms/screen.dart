import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/LoginBeforeIdentify/LoginTerms/TermsDetail/screen.dart';
import 'package:yakal/screens/Login/LoginBeforeIdentify/LoginTerms/style.dart';
import 'package:yakal/screens/Login/LoginBeforeIdentify/screen.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Login/auth_check_button.dart';

class LoginTermsScreen extends StatelessWidget {
  static const routeName = "/terms";

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

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(_TermsCheckedController());
    final UserViewModel userViewModel =
        Get.put(UserViewModel(), permanent: true);
    final routeController = Get.put(LoginBeforeIdentifyController());

    return Padding(
      padding: const EdgeInsets.all(30.0),
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
                    style: LoginTermsStyle.boldTitle,
                  ),
                  Text(
                    "을 확인해주세요",
                    style: LoginTermsStyle.title,
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
                    style: LoginTermsStyle.checkedAll,
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
                              style: (terms[index]["isRequired"] as bool
                                  ? LoginTermsStyle.checkedRequired
                                  : LoginTermsStyle.checkedOptional),
                            ),
                            Text(
                              " ${terms[index]["title"] as String}",
                              style: LoginTermsStyle.checkedRequired,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            showGeneralDialog(
                              barrierDismissible: false,
                              context: context,
                              transitionDuration: const Duration(
                                milliseconds: 250,
                              ),
                              transitionBuilder: (context, animation,
                                  secondaryAnimation, child) {
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
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return TermsDetailScreen(
                                  title: terms[index]["title"] as String,
                                  content: terms[index]["content"] as String,
                                );
                              },
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
                    final canMoveNext = controller.isCheckedRequiredAll();

                    return TextButton(
                      onPressed: canMoveNext
                          ? () {
                              var isAgreedMarketing = controller.isChecked[3];
                              userViewModel
                                  .updateMarketingAgreement(isAgreedMarketing);
                              routeController.goToIdentifyEntry();
                            }
                          : null,
                      style: TextButton.styleFrom(
                        backgroundColor:
                            canMoveNext ? ColorStyles.main : ColorStyles.gray2,
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
                          color: canMoveNext
                              ? ColorStyles.white
                              : ColorStyles.gray3,
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
    );
  }
}

class _TermsCheckedController extends GetxController {
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

  bool isCheckedRequiredAll() {
    return isChecked[0] && isChecked[1] && isChecked[2];
  }
}
