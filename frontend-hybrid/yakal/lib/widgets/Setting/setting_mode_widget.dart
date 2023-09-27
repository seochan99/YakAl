import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingModeWidget extends StatefulWidget {
  const SettingModeWidget({super.key});

  @override
  State<SettingModeWidget> createState() => _SettingModeWidgetState();
}

class _SettingModeWidgetState extends State<SettingModeWidget> {
  String selectedMode = 'normal';

  Future<void> _saveSelectedMode(String mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_mode', mode);
  }

  Future<void> _loadSelectedMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedMode = prefs.getString('selected_mode') ?? 'normal';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSelectedMode();
  }

  void _handleModeTap(String mode) {
    setState(() {
      selectedMode = mode;
      _saveSelectedMode(mode);
    });
  }

  // 일반 모드, 라이트 모드 타일
  Widget buildModeTile(String mode, String title, String subtitle) {
    final isSelected = mode == selectedMode;
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
        buildModeTile('normal', '일반 모드', '약알의 일반적인 모드입니다.'),
        const SizedBox(height: 16),
        buildModeTile(
            'light', '라이트 모드', '시니어를 위한 쉬운 모드입니다.\n다제약물 정보가 포함되어 있습니다.'),
      ],
    );
  }
}
