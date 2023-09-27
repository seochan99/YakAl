import 'package:get/get.dart';
import '../../models/Profile/user.dart';

class UserViewModel extends GetxController {
  var user = User(nickName: '약 알', testCnt: 0).obs;

  //  닉네임 변경
  void updateNickName(String newNickName) {
    user.update((val) {
      val?.nickName = newNickName;
    });
  }

  // 테스트 횟수 증가
  void incrementTestCount() {
    user.update((val) {
      val?.testCnt++;
    });
  }
}
