import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/utilities/api/api.dart';

/*
  * PillTodoProvider
  * Todo를 위한 통신 라이브러리를 사용하여 API 통신을 담당하는 클래스
 */
class PillTodoProvider {
  Future<Map<String, dynamic>> getPillTodoParents(DateTime dateTime) async {
    var dio = await authDioWithContext();

    var response = await dio
        .get("/doses/day/${DateFormat('yyyy-MM-dd').format(dateTime)}");

    if (response.statusCode == 200) {
      print(response.data['data']);
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
      }).catchError((e) {
        print("Error occurred for request with kdCode: $kdCode");
        // Handle specific error for the failed request here
      }));
    }

    try {
      await Future.wait(futures);
    } catch (e) {
      print("Error occurred for request with kdCode: $kdCodeList");
      // Handle specific error for the failed request here
    }
    List<Response> responses = await Future.wait(futures);
    Map<String, String> base64ImageMap = {};

    for (int i = 0; i < responses.length; i++) {
      if (responses[i].statusCode == 200) {
        Map<String, dynamic> jsonResponse = responses[i].data;

        base64ImageMap[kdCodeList[i]] =
            jsonResponse['DrugInfo']['IdentaImage'] ?? "";
      } else {
        base64ImageMap[kdCodeList[i]] = "";
      }
    }

    return base64ImageMap;
  }

  Future<bool> updatePillTodoParent(
      DateTime dateTime, ETakingTime takingTime, bool isTaken) async {
    var dio = await authDioWithContext();
    String date = DateFormat('yyyy-MM-dd').format(dateTime);
    String takingTimeStr = takingTime.toString().split('.').last;

    var response = await dio.patch("/doses/taken/$date/$takingTimeStr", data: {
      "isTaken": isTaken,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePillTodoChildren(
      int doseId, ETakingTime takingTime, bool isTaken) async {
    var dio = await authDioWithContext();

    var response = await dio.patch(
      "/doses/taken/$doseId",
      data: {
        "isTaken": isTaken,
        "dosingTime": takingTime.toString().split(".").last,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> readUserIsDetail() async {
    final prefs = await SharedPreferences.getInstance();
    bool mode = prefs.getBool("MODE") ?? true;

    return mode;
  }
}
