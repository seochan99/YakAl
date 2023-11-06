import 'package:get/get.dart';
import 'package:yakal/models/Profile/user.dart';
import 'package:yakal/utilities/api/api.dart';

class AppointmentController extends GetxController {
  var epxerts = <Expert>[].obs;
  var myExperts = <Expert>[].obs;

  // 전문가 호출
  Future<void> getExperts(String name) async {
    try {
      var dio = await authDioWithContext();
      final response = await dio.get("/users/expert-search?name=$name");

      if (response.statusCode == 200) {
        dynamic responseData = response.data;
        print("epxertsData : $responseData");
        final List<dynamic> epxertsData =
            responseData["data"]; // 'results' 대신 "data" 사용
        print("Debugging epxertsData");
        print(epxertsData);

        epxerts.clear(); // Clear the existing list if needed
        epxerts
            .addAll(epxertsData.map((data) => Expert.fromJson(data)).toList());
      } else {
        throw Exception('Failed to fetch guardian information');
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  // 전문가 POST
  Future<void> postExperts(
      int id, String name, String medicalEstablishment) async {
    // myExperts 에 id,name,birthDate 객체 리스트 요소 하나
    myExperts.add(
        Expert(id: id, name: name, medicalEstablishment: medicalEstablishment));
    try {
      var dio = await authDioWithContext();
      final response = await dio.post("/medical-appointment/$id");

      if (response.statusCode == 200) {
        print("postExperts POST 성공 ");
      } else {}
    } catch (e) {}
  }
}
