import 'package:get/get.dart';
import 'package:yakal/models/Profile/user.dart';
import 'package:yakal/utilities/api/api.dart';

class GuardianController extends GetxController {
  var guardians = <Guardian>[].obs;

  Future<void> getGuardians(String name, String birthday) async {
    try {
      var dio = await authDioWithContext();
      final response =
          await dio.get("/users/general-search?date=$birthday&nickname=$name");

      if (response.statusCode == 200) {
        dynamic responseData = response.data;

        print("guardianData : $responseData");
        final List<dynamic> guardianData = responseData["data"];

        guardians.clear(); // Clear the existing list if needed
        guardians.addAll(
            guardianData.map((data) => Guardian.fromJson(data)).toList());
      } else {
        throw Exception('Failed to fetch guardian information');
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }
}
