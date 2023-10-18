import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:yakal/screens/Calender/calender_screen.dart';
import 'package:yakal/screens/Detail/screen.dart';
import 'package:yakal/screens/Home/home_screen.dart';
import 'package:yakal/screens/Login/Identification/screen.dart';
import 'package:yakal/screens/Login/KakaoLogin/screen.dart';
import 'package:yakal/screens/Login/LoginEntry/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/screen.dart';
import 'package:yakal/screens/Medication/AddMedicine/screen.dart';
import 'package:yakal/screens/Medication/direct/DirectResult/direct_result.dart';
import 'package:yakal/screens/Medication/direct/medication_direct_screen.dart';
import 'package:yakal/screens/Medication/ocrEnvelop/EnvelopAnalysis/screen.dart';
import 'package:yakal/screens/Medication/ocrEnvelop/EnvelopOcrEntry/screen.dart';
import 'package:yakal/screens/Medication/ocrEnvelop/EnvelopShot/screen.dart';
import 'package:yakal/screens/Medication/ocrEnvelop/EnvelopShotReview/screen.dart';
import 'package:yakal/screens/Medication/ocrGeneral/medication_ocr_General_screen.dart';
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

  const storage = FlutterSecureStorage();
  final accessToken = await storage.read(key: 'ACCESS_TOKEN');

  // Fix to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // locator init
  initializeDateFormatting().then((value) =>
      runApp(MyApp(initialRoute: accessToken != null ? '/' : '/login')));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

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
      initialRoute: initialRoute,
      // 라우팅 설정
      getPages: [
        GetPage(
          name: '/',
          page: () => const MyBottomNavigationBar(),
        ),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(
          name: "/profile/boho",
          page: () => InfoBohoScreen(),
        ),
        GetPage(
          name: "/profile/hospital",
          page: () => InfoHospitalScreen(),
        ),
        GetPage(
          name: "/profile/star",
          page: () => InfoStarScreen(),
        ),
        GetPage(
          name: "/profile/wish",
          page: () => const ProfileWishScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginEntryScreen(),
          children: [
            GetPage(
              name: '/process',
              page: () => LoginProcess(),
              transition: Transition.noTransition,
            ),
            GetPage(
              name: '/kakao',
              page: () => const KakaoLoginScreen(),
            ),
            GetPage(
              name: '/identify/process',
              page: () => const IdentificationScreen(),
            ),
          ],
        ),
        GetPage(
          name: '/setting/app',
          page: () => const SettingScreen(),
        ),
        GetPage(
          name: '/setting/alert',
          page: () => const AlertScreen(),
        ),
        GetPage(
          name: '/signout',
          page: () => const SettingSignoutScreen(),
        ),
        GetPage(
          name: "/seniorSurvey",
          page: () => const SurveySeniorScreen(),
        ),
        GetPage(
          name: "/normalSurvey",
          page: () => const SurveyNormalScreen(),
        ),
        GetPage(
          name: "/survey/result",
          page: () => const SurveyResultScreen(),
        ),
        GetPage(
          name: "/calendar",
          page: () => CalenderScreen(),
        ),
        // /home/pill/add/$type
        GetPage(
            name: "/pill/add/direct",
            page: () => const MedicationAddScreen(),
            children: [
              GetPage(
                name: "/result",
                page: () => MedicationDirectResult(),
              ),
            ]),
        GetPage(
          name: "/pill/add/ocrGeneral",
          page: () => const MedicationOcrGeneralScreen(),
        ),
        GetPage(
          name: "/pill/add/ocrEnvelop",
          page: () => const EnvelopOcrEntryScreen(),
          children: [
            GetPage(
              name: "/shot",
              page: () => const EnvelopShotScreen(),
            ),
            GetPage(
              name: "/review",
              page: () => const EnvelopShotReviewScreen(),
            ),
            GetPage(
              name: "/process",
              page: () => const EnvelopAnalysisScreen(),
            ),
          ],
        ),
        GetPage(
          name: "/pill/add/final",
          page: () => AddMedicineScreen(),
        ),
        GetPage(name: "/pill/detail", page: () => const PillDetailScreen()),
      ],
    );
  }
}
