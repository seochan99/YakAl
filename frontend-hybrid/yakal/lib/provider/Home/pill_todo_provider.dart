import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/utilities/api/api.dart';

/*
  * PillTodoProvider
  * 통신 라이브러리를 사용하여 API 통신을 담당하는 클래스
 */
class PillTodoProvider {
  Future<Map<String, dynamic>> getPillTodoParents(DateTime dateTime) async {
    var dio = await authDioWithContext();

    var response =
        await dio.get("/dose/day/${DateFormat('yyyy-MM-dd').format(dateTime)}");

    if (response.statusCode == 200) {
      return response.data['data'];
    } else {
      print("Failed to load PillTodoParents");
      throw Exception('Failed to load PillTodoParents');
    }
  }

  Future<Map<String, String>> getKimsBase64Image(Set<String> kdCodeSet) async {
    var dio = kimsDio();

    List<Future<Response<dynamic>>> futures = [];
    List<String> kdCodeList = [];

    for (var kdCode in kdCodeSet) {
      kdCodeList.add(kdCode);
      futures.add(dio.get("/drug/info", queryParameters: {
        "drugcode": kdCode,
        "drugType": "N",
      }));
    }

    List<Response> responses = await Future.wait(futures);
    Map<String, String> base64ImageMap = {};

    for (int i = 0; i < responses.length; i++) {
      if (responses[i].statusCode == 200) {
        Map<String, dynamic> jsonResponse = responses[i].data;

        base64ImageMap[kdCodeList[i]] =
            jsonResponse['DrugInfo']['IdentaImage'] ?? "";
      }
    }

    return base64ImageMap;
  }

  Future<bool> updatePillTodoParent(
      DateTime dateTime, ETakingTime takingTime, bool isTaken) async {
    var dio = await authDioWithContext();
    String date = DateFormat('yyyy-MM-dd').format(dateTime);
    String takingTimeStr = takingTime.toString().split('.').last;

    var response = await dio.patch("/dose/taken/$date/$takingTimeStr", data: {
      "isTaken": isTaken,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePillTodoChildren(int doseId, bool isTaken) async {
    var dio = await authDioWithContext();

    var response = await dio.patch("/dose/taken/$doseId", data: {
      "isTaken": isTaken,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
