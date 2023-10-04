import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/enum/mode.dart';

class User {
  String nickName;
  EMode mode;

  User({
    this.nickName = "",
    this.mode = EMode.NONE,
  }) {
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    nickName = prefs.getString("NICKNAME") ?? "";

    if (prefs.getInt("MODE") != null) {
      mode = EMode.values[prefs.getInt("MODE")!];
    } else {
      mode = EMode.NONE;
    }
  }

  Future<void> setNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("NICKNAME", nickname);
    nickName = nickname;
  }

  Future<void> setMode(EMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("MODE", mode.index);
    this.mode = mode;
  }
}
