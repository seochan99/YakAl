/*
  * CalendarProvider
  * Calendar를 위한 통신 라이브러리를 사용하여 API 통신을 담당하는 클래스
 */
import 'package:intl/intl.dart';

import '../../utilities/api/api.dart';

class CalendarProvider {
  Future<List<dynamic>> getCalendarInfoBetweenDate(
      DateTime startDateTime, DateTime endDateTime) async {
    var dio = await authDioWithContext();

    var responseJson =
        await dio.get("/doses/between", queryParameters: <String, dynamic>{
      "startDate": DateFormat('yyyy-MM-dd').format(startDateTime),
      "endDate": DateFormat('yyyy-MM-dd').format(endDateTime),
    });

    if (responseJson.statusCode == 200) {
      return responseJson.data['data'];
    } else {
      print("Failed to load Calendar");
      throw Exception('Failed to load Calendar');
    }
  }
}
