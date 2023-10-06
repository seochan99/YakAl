import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:yakal/screens/Auth/auth_login_screen.dart';
import 'package:yakal/screens/Calender/calender_screen.dart';
import 'package:yakal/screens/Home/home_screen.dart';
import 'package:yakal/screens/Login/Identification/screen.dart';
import 'package:yakal/screens/Login/IdentificationEntry/screen.dart';
import 'package:yakal/screens/Login/IdentificationResult/screen.dart';
import 'package:yakal/screens/Login/KakoLogin/screen.dart';
import 'package:yakal/screens/Login/LoginEntry/screen.dart';
import 'package:yakal/screens/Login/LoginFinished/screen.dart';
import 'package:yakal/screens/Login/LoginTerms/screen.dart';
import 'package:yakal/screens/Login/ModeSelection/screen.dart';
import 'package:yakal/screens/Login/NicknameInput/screen.dart';
import 'package:yakal/screens/Login/SetMode/screen.dart';
import 'package:yakal/screens/Login/SetNickname/screen.dart';
import 'package:yakal/screens/Profile/Info/info_boho_screen.dart';
import 'package:yakal/screens/Profile/Info/info_hospital_screen.dart';
import 'package:yakal/screens/Profile/Info/info_star_screen.dart';
import 'package:yakal/screens/Profile/Wish/profile_wish_screen.dart';
import 'package:yakal/screens/Profile/profile_screen.dart';
import 'package:yakal/screens/Setting/alert_setting_screen.dart';
import 'package:yakal/screens/Setting/setting_screen.dart';
import 'package:yakal/screens/Setting/setting_signout_screen.dart';
import 'package:yakal/screens/Survey/survery_senior_screen.dart';
import 'package:yakal/screens/Survey/survey_normal_screen.dart';
import 'package:yakal/screens/Survey/survey_result_screen.dart';
import 'package:yakal/widgets/Base/my_bottom_navigation_bar.dart';

void main() async {
  await dotenv.load(fileName: "assets/config/.env");

  // kakao sdk init
  KakaoSdk.init(nativeAppKey: '${dotenv.env['KAKAO_NATIVE_APP_KEY']}');
  
  // Setup splash
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // locator init
  initializeDateFormatting().then((value) => runApp(const MyApp()));
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
      initialRoute: '/login',
      // 라우팅 설정
      getPages: [
        GetPage(name: '/', page: () => const MyBottomNavigationBar()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: "/profile/boho", page: () => InfoBohoScreen()),
        GetPage(name: "/profile/hospital", page: () => InfoHospitalScreen()),
        GetPage(name: "/profile/star", page: () => InfoStarScreen()),
        GetPage(name: "/profile/wish", page: () => const ProfileWishScreen()),
        GetPage(
          name: '/login',
          page: () => const LoginEntryScreen(),
          children: [
            GetPage(
              name: '/kakao',
              page: () => const KakaoLoginScreen(),
            ),
            GetPage(
              name: '/terms',
              page: () => const LoginTermsScreen(),
            ),
            GetPage(
              name: '/identify/entry',
              page: () => const IdentificationEntryScreen(),
            ),
            GetPage(
              name: '/identify/process',
              page: () => const IdentificationScreen(),
            ),
            GetPage(
              name: '/identify/result',
              page: () => const IdentificationResultScreen(),
            ),
            GetPage(
              name: '/nickname',
              page: () => const NicknameInputScreen(),
            ),
            GetPage(
              name: '/nickname/process',
              page: () => SetNicknameScreen(),
            ),
            GetPage(
              name: '/mode',
              page: () => const ModeSelectionScreen(),
            ),
            GetPage(
              name: '/mode/process',
              page: () => SetModeScreen(),
            ),
            GetPage(
              name: '/finish',
              page: () => const LoginFinishedScreen(),
            ),
          ],
        ),
        GetPage(name: '/setting/app', page: () => const SettingScreen()),
        GetPage(name: '/setting/alert', page: () => const AlertScreen()),
        GetPage(name: '/signout', page: () => const SettingSignoutScreen()),
        GetPage(name: "/seniorSurvey", page: () => const SurveySeniorScreen()),
        GetPage(name: "/normalSurvey", page: () => const SurveyNormalScreen()),
        GetPage(name: "/survey/result", page: () => const SurveyResultScreen()),
        GetPage(name: "/calendar", page: () => CalenderScreen()),
      ],
    );
  }
}
