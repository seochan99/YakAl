import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/provider/Login/login_terms_provider.dart';
import 'package:yakal/screens/Login/LoginProcess/LoginTerms/TermsDetail/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/LoginTerms/style.dart';
import 'package:yakal/screens/Login/LoginProcess/login_route.dart';
import 'package:yakal/screens/Login/LoginProcess/screen.dart';
import 'package:yakal/utilities/enum/terms.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';
import 'package:yakal/widgets/Login/auth_check_button.dart';

class LoginTermsScreen extends StatefulWidget {
  const LoginTermsScreen({super.key});

  @override
  State<LoginTermsScreen> createState() => _LoginTermsScreenState();
}

class _LoginTermsScreenState extends State<LoginTermsScreen> {
  final userViewModel = Get.find<UserViewModel>();
  final routeController = Get.find<LoginRouteController>();
  final termsCheckedController = Get.put(_TermsCheckedController());

  final loginTermsProvider = LoginTermsProvider();

  void onPressedNextButton() {
    var isAgreedMarketing = termsCheckedController.isChecked[3];

    userViewModel.updateMarketingAgreement(isAgreedMarketing).then(
      (_) {
        routeController.goto(LoginRoute.identifyEntry);
      },
    ).catchError(
      (_) {
        if (!context.mounted) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("약관 동의 여부 설정에 실패했습니다."),
            duration: Duration(seconds: 3),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        isChecked: termsCheckedController.isCheckedAll(),
                        onPressed: termsCheckedController.toggleAll,
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
                ETerms.values.length,
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
                                  isChecked:
                                      termsCheckedController.isChecked[index],
                                  onPressed:
                                      termsCheckedController.toggle(index),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              "(${ETerms.values[index].isRequired ? "필수" : "선택"})",
                              style: (ETerms.values[index].isRequired
                                  ? LoginTermsStyle.checkedRequired
                                  : LoginTermsStyle.checkedOptional),
                            ),
                            Text(
                              " ${ETerms.values[index].title}",
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
                                  terms: ETerms.values[index],
                                  loginTermsProvider: loginTermsProvider,
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
                    final canMoveNext =
                        termsCheckedController.isCheckedRequiredAll();

                    return TextButton(
                      onPressed: canMoveNext ? onPressedNextButton : null,
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
