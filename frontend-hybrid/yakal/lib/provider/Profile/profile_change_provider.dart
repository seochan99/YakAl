import 'package:intl/intl.dart';
import 'package:yakal/utilities/api/api.dart';

/*
  * PillTodoProvider
  * 통신 라이브러리를 사용하여 API 통신을 담당하는 클래스
 */
class PillTodoProvider {
  Future<Map<String, dynamic>> getPillTodoParents(DateTime dateTime) async {
    var dio = await authDioWithContext();

    var response = await dio
        .get("/doses/day/${DateFormat('yyyy-MM-dd').format(dateTime)}");

    if (response.statusCode == 200) {
      return response.data['data'];
    } else {
      print("Failed to load PillTodoParents");
      throw Exception('Failed to load PillTodoParents');
    }
  }
}
