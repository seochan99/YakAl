import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  // 환경 변수 불러오기
  // await dotenv.load(fileName: 'assets/config/.env');

  // spalsh
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      title: '약 알',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyTabBar(),
        '/home': (context) => const HomeTab(),
        '/mypage': (context) => const MyPageTab(),
      },
    );
  }
}

class MyTabBar extends StatelessWidget {
  const MyTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('약 알'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '홈'),
              Tab(text: '마이페이지'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeTab(),
            MyPageTab(),
          ],
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'This is the Home Tab',
          ),
        ],
      ),
    );
  }
}

class MyPageTab extends StatelessWidget {
  const MyPageTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'This is the MyPage Tab',
          ),
        ],
      ),
    );
  }
}
