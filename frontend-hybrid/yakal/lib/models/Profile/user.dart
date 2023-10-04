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
    nickName = prefs.getString("USERNAME") ?? "";

    if (prefs.getInt("MODE") != null) {
      mode = EMode.values[prefs.getInt("MODE")!];
    } else {
      mode = EMode.NONE;
    }
  }
}
