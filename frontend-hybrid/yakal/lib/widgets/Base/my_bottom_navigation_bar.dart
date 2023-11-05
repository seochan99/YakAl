import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:yakal/screens/Home/home_screen.dart';
import 'package:yakal/screens/Profile/profile_screen.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          const MyBottomNavigationBarContent(), // Use a separate widget for content
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}

class MyBottomNavigationBarContent extends StatelessWidget {
  const MyBottomNavigationBarContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyBottomNavigationBarController controller =
        Get.put(MyBottomNavigationBarController());

    return Obx(() {
      return IndexedStack(
        index: controller.currentIndex.value,
        children: [
          const HomeScreen(),
          ProfileScreen(),
        ],
      );
    });
  }
}

class MyBottomNavBar extends StatelessWidget {
  final MyBottomNavigationBarController mybottomNavigationBarController =
      Get.put(MyBottomNavigationBarController(), permanent: true);

  MyBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.white,
      ),
      child: Obx(
        () {
          // GetX를 사용하여 컨트롤러의 currentIndex를 가져옴
          return BottomNavigationBar(
            currentIndex: mybottomNavigationBarController.currentIndex.value,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '내 정보',
              ),
            ],
            onTap: mybottomNavigationBarController.changeTabIndex,
          );
        },
      ),
    );
  }
}

class MyBottomNavigationBarController extends GetxController {
  // rXInt는 currentIndex의 값이 변경될 때마다 화면을 다시 그리게
  RxInt currentIndex = 0.obs;

// 탭을 변경하는 메서드
  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}
