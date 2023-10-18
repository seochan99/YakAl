/*
  * CalendarProvider
  * Calendar를 위한 통신 라이브러리를 사용하여 API 통신을 담당하는 클래스
 */
import 'package:intl/intl.dart';

import '../../utilities/api/api.dart';

class CalendarProvider {
  Future<Map<String, dynamic>> getCalendar(DateTime dateTime) async {
    var dio = await authDioWithContext();

    var response =
        await dio.get("/dose/day/${DateFormat('yyyy-MM-dd').format(dateTime)}");

    if (response.statusCode == 200) {
      print(response.data['data']);
      return response.data['data'];
    } else {
      print("Failed to load Calendar");
      throw Exception('Failed to load Calendar');
    }
  }
}
