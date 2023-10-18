import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';

class SettingModeWidget extends StatefulWidget {
  const SettingModeWidget({super.key});

  @override
  State<SettingModeWidget> createState() => _SettingModeWidgetState();
}

class _SettingModeWidgetState extends State<SettingModeWidget> {
  bool isLightMode = false;
  UserViewModel userViewModel = UserViewModel();
// 저장된 모드 저장하기
  Future<void> _saveSelectedMode(bool mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('MODE', mode);
  }

  // 저장된 모드 불러오기
  Future<void> _loadSelectedMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLightMode = prefs.getBool('MODE') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSelectedMode();
  }

// 모드 탭
  void _handleModeTap(bool mode) {
    userViewModel.updateMode(mode);
    setState(() {
      isLightMode = mode;
      _saveSelectedMode(mode);
    });
  }

  // 일반 모드, 라이트 모드 타일
  Widget buildModeTile(bool mode, String title, String subtitle) {
    final isSelected = mode == isLightMode;
    final tileColor =
        isSelected ? const Color(0xFFF1F5FE) : const Color(0xFFFFFFFF);
    final borderColor =
        isSelected ? const Color(0xFF5588FD) : const Color(0xFFE9E9EE);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          title,
          style: const TextStyle(
              color: Color(0xFF464655),
              fontSize: 24,
              fontWeight: FontWeight.w500),
        ),
      ),
      subtitle: Text(subtitle,
          style: const TextStyle(
            color: Color(0xFF464655),
            fontSize: 15,
          )),
      tileColor: tileColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: borderColor, width: 2.0),
      ),
      onTap: () {
        _handleModeTap(mode);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildModeTile(false, '일반 모드', '약알의 일반적인 모드입니다.'),
        const SizedBox(height: 16),
        buildModeTile(true, '라이트 모드', '시니어를 위한 쉬운 모드입니다.\n다제약물 정보가 포함되어 있습니다.'),
      ],
    );
  }
}
