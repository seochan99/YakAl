import 'package:dio/dio.dart';
import 'package:yakal/utilities/api/api.dart';

class AddMedicineProvider {
  Future<String?> getMedicineBase64Image(String kimsCode) async {
    final dio = kimsDio();

    final Uri url = Uri.parse("/drug/info").replace(queryParameters: {
      "drugcode": kimsCode,
      "drugType": "K",
    });

    try {
      final response = await dio.get(url.toString());

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;

        String image = jsonResponse['DrugInfo']['IdentaImage'] ?? "";
        return image;
      } else {
        assert(false, "🚨 [Status Code Is Wrong] Check called API is correct.");
        return null;
      }
    } on DioException catch (error) {
      return null;
    }
  }
}
