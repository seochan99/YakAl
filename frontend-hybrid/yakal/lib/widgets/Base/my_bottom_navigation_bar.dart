// my_bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:yakal/screens/Home/home_screen.dart';
import 'package:yakal/screens/Profile/profile_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  // 현재 선택된 탭
  int _currentIndex = 0;

  // 홈, 마이페이지
  final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('약 알'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '마이페이지',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
