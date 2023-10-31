import 'package:get/get.dart';
import 'package:yakal/models/Profile/user.dart';
import 'package:yakal/utilities/api/api.dart';

class AppointmentController extends GetxController {
  var epxerts = <Guardian>[].obs;
  var myExperts = <Guardian>[].obs;

  // 전문가 호출
  Future<void> getExperts(String name) async {
    try {
      var dio = await authDioWithContext();
      final response = await dio.get("/user/expert-search?name=$name");

      if (response.statusCode == 200) {
        dynamic responseData = response.data;
        print("epxertsData : $responseData");
        final List<dynamic> epxertsData = responseData["data"];

        epxerts.clear(); // Clear the existing list if needed
        epxerts.addAll(
            epxertsData.map((data) => Guardian.fromJson(data)).toList());
      } else {
        throw Exception('Failed to fetch guardian information');
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  // 전문가 POST
  Future<void> postExperts(int id, String name, String birthDate) async {
    // myExperts 에 id,name,birthDate 객체 리스트 요소 하나
    myExperts.add(Guardian(id: id, name: name, birthDate: birthDate));
    try {
      var dio = await authDioWithContext();
      final response = await dio.post("/medical-appointment/$id");

      if (response.statusCode == 200) {
        print("postExperts POST 성공 ");
      } else {}
    } catch (e) {}
  }
}
