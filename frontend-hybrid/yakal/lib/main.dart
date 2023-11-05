import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
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
import 'package:yakal/screens/Login/LoginProcess/login_route.dart';
import 'package:yakal/screens/Login/LoginProcess/screen.dart';
import 'package:yakal/screens/Login/SocialLogin/screen.dart';
import 'package:yakal/screens/Medication/AddMedicine/screen.dart';
import 'package:yakal/screens/Medication/Prescription/screem.dart';
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

void main() async {
  await dotenv.load(fileName: "assets/config/.env");

  // kakao sdk init
  KakaoSdk.init(nativeAppKey: '${dotenv.env['KAKAO_NATIVE_APP_KEY']}');

  // Setup splash
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  const storage = FlutterSecureStorage();
  final accessToken = await storage.read(key: 'ACCESS_TOKEN');

  // Fix to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  late String initialRoute = "/login";
  final routeController = Get.put(LoginRouteController());

  if (accessToken != null) {
    final dio = await authDioWithContext();

    try {
      final response = await dio.get("/user/check/register");

      if (response.data["data"]["isRegistered"]
              ["isOptionalAgreementAccepted"] ==
          null) {
        if (kDebugMode) {
          print(
              "🚨 [User Terms Agreement Is Not Finished] Redirect To Terms Page.");
        }

        routeController.goto(LoginRoute.terms);
        initialRoute = "/login/process";
      } else if (response.data["data"]["isRegistered"]["isIdentified"] ==
          false) {
        if (kDebugMode) {
          print(
              "🚨 [User Identification Is Not Finished] Redirect To Identification Entry Page.");
        }

        routeController.goto(LoginRoute.identifyEntry);
        initialRoute = "/login/process";
      } else {
        if (kDebugMode) {
          print("🎉 [User Do All Login Process] Redirect To Home Page.");
        }

        initialRoute = "/";
      }
    } on DioException catch (error) {
      if (kDebugMode) {
        print("🚨 [User Info Check Error] Redirect To Login Entry Page.");
      }

      storage.deleteAll();
    }
  } else {
    if (kDebugMode) {
      print("🚨 [Access Token Is Not Found] Redirect To Login Entry Page.");
    }
  }

  initializeDateFormatting()
      .then((value) => runApp(MyApp(initialRoute: initialRoute)));
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
      // initialRoute: initialRoute,
      initialRoute: "/login/process",
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
        GetPage(
          name: "/pill/add/prescription",
          page: () => const PrescriptionScreen(),
        ),
        GetPage(name: "/pill/detail", page: () => const PillDetailScreen()),
      ],
    );
  }
}
