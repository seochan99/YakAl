import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:yakal/widgets/Base/my_bottom_navigation_bar.dart';

void main() async {
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
    return MaterialApp(
      title: '약 알',
      theme: ThemeData(
        useMaterial3: true,
      ),
      // 하단 탭
      home: const MyBottomNavigationBar(),
    );
  }
}
