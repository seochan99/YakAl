import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/api/api.dart';
import 'package:yakal/viewModels/Profile/user_view_model.dart';

class IdentificationResultProvider {
  final UserViewModel userViewModel = Get.put(UserViewModel(), permanent: true);

  Future<bool> identify(String impUid) async {
    var dio = await authDioWithContext();

    try {
      var response =
          await dio.patch("/users/identify", data: {"impUid": impUid});

      if (response.statusCode == 200) {
        userViewModel.updateIsIdentified(true);
        return true;
      } else {
        assert(false, "🚨 [Status Code Is Wrong] Check called API is correct.");
        return false;
      }
    } on DioException {
      return false;
    }
  }
}
