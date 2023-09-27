import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:yakal/screens/Auth/auth_login_screen.dart';
import 'package:yakal/screens/Home/home_screen.dart';
import 'package:yakal/screens/Profile/profile_screen.dart';
import 'package:yakal/screens/Setting/setting_screen.dart';
import 'package:yakal/widgets/Base/my_bottom_navigation_bar.dart';

void main() async {
  dotenv.load(fileName: ".env");
  // kakao sdk init
  KakaoSdk.init(nativeAppKey: '네이티브 앱 키');
  // Setup splash
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Remove splash
    FlutterNativeSplash.remove();

    // 앱 실행
    return GetMaterialApp(
      title: '약 알',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFf6f6f8),
      ),
      initialRoute: '/',
      // 라우팅 설정
      getPages: [
        GetPage(name: '/', page: () => const MyBottomNavigationBar()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/login', page: () => const AuthLoginScreen()),
        GetPage(name: '/appSetting', page: () => const SettingScreen()),
      ],
    );
  }
}
