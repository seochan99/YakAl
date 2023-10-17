import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Login/LoginProcess/ModeSelection/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/NicknameInput/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/login_route.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Login/animated_indexed_stack.dart';
import 'package:yakal/widgets/Login/login_app_bar.dart';

class LoginProcess extends StatelessWidget {
  final routeController = Get.put(LoginRouteController());
  final nicknameLoadingController = Get.put(NicknameInputLoadingController());
  final modeLoadingController = Get.put(ModeSelectionLoadingController());

  LoginProcess({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        var routeIndex = routeController.routeIndex.value;
        var nicknameIsLoading = nicknameLoadingController.isLoading.value;
        var modeIsLoading = modeLoadingController.isLoading.value;

        return Container(
          color: ColorStyles.white,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: ColorStyles.white,
              resizeToAvoidBottomInset: false,
              appBar: LoginAppBar(
                onPressed: nicknameIsLoading || modeIsLoading
                    ? () {}
                    : LoginRoute.back(
                  routeIndex,
                  context,
                ),
                progress: LoginRoute.values[routeIndex].loginProcess,
              ),
              body: AnimatedIndexedStack(
                index: routeIndex,
                children: List.generate(
                  LoginRoute.values.length,
                      (index) {
                    return routeIndex == index
                        ? LoginRoute.values[index].screen
                        : Container();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LoginRouteController extends GetxController {
  RxInt routeIndex = 0.obs;

  void goto(LoginRoute loginRoute) {
    routeIndex.value = loginRoute.index;
  }
}
