import 'package:dio/dio.dart';
import 'package:yakal/utilities/api/api.dart';

class IdentificationResultProvider {
  Future<bool> identify(String impUid) async {
    var dio = await authDioWithContext();

    try {
      var response =
          await dio.patch("/user/identify", data: {"impUid": impUid});

      if (response.statusCode == 200) {
        return true;
      } else {
        assert(false, "🚨 [Status Code Is Wrong] Check called API is correct.");
        return false;
      }
    } on DioException catch (error) {
      return false;
    }
  }
}
