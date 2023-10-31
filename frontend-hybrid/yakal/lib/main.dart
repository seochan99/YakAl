import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:yakal/screens/Calender/calender_screen.dart';
import 'package:yakal/screens/Detail/screen.dart';
import 'package:yakal/screens/Home/home_screen.dart';
import 'package:yakal/screens/Login/Identification/screen.dart';
import 'package:yakal/screens/Login/LoginProcess/screen.dart';
import 'package:yakal/screens/Login/SocialLogin/screen.dart';
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
import 'package:yakal/utilities/api/api.dart';
import 'package:yakal/widgets/Base/my_bottom_navigation_bar.dart';

// device 토큰 저장
Future<void> sendDeviceToken(String deviceToken, bool isIos) async {
  try {
    Map<String, dynamic> requestBody = {
      'device_token': deviceToken,
      'is_ios': false
    };

    var dio = await authDioWithContext();
    var response = await dio.put("/user/device", data: requestBody);

    if (response.statusCode == 200) {
      print('sendDeviceToken - Success');
    } else {
      print('sendDeviceToken - Failure: ${response.statusCode}');
    }
  } catch (error) {}
}

void main() async {
  await dotenv.load(fileName: "assets/config/.env");

  // await Firebase.initializeApp();

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

  // initializeNotification();

  // final token = await FirebaseMessaging.instance.getToken();
  // print("FCM TOKEN : $token ");
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // if it's a RTL language
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
        // include country code too
      ],
      theme: ThemeData(
        fontFamily: 'Pretendard',
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,

        // colorScheme:
        //   const ColorScheme(
        //     brightness: Brightness.light,
        //     // primary는 앱바, 플로팅버튼, 텍스트필드 등의 색상을 지정합니다.
        //     primary: Colors.blue,
        //     onPrimary: Colors.white,
        //     // secondary는 앱바의 타이틀, 플로팅버튼의 아이콘 등의 색상을 지정합니다.
        //     secondary: Colors.white,
        //     onSecondary: Colors.white,
        //     // error는 에러 메시지 등의 색상을 지정합니다.
        //     error: Colors.red,
        //     onError: Colors.white,
        //     // background는 앱의 배경색을 지정합니다.
        //     background: Colors.white,
        //     onBackground: Colors.white,
        //     // surface는 카드, 버튼 등의 색상을 지정합니다.
        //     surface: Colors.white,
        //     onSurface: Colors.black,
        //   ),
        scaffoldBackgroundColor: const Color(0xFFf6f6f8),
      ),
      initialRoute: initialRoute,
      // initialRoute: "/login",
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
          page: () => const SocialLoginScreen(),
          children: [
            GetPage(
              name: '/process',
              page: () => LoginProcess(),
              transition: Transition.noTransition,
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
