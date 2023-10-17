import 'package:cached_memory_image/cached_image_base64_manager.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:yakal/utilities/api/api.dart';

import '../../models/Home/pill_todo_children.dart';

/*
  * PillTodoProvider
  * 통신 라이브러리를 사용하여 API 통신을 담당하는 클래스
 */
class PillTodoProvider {
  Future<Map<String, dynamic>> getPillTodoParents(DateTime dateTime) async {
    var dio = await authDioWithContext();

    // yyyy - MM - dd 만 입력
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
}
