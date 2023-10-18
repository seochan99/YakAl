import 'package:dio/dio.dart';
import 'package:yakal/models/Medication/dose_name_code_model.dart';
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

  Future<DoseNameCodeModel?> getKDCodeAndATCCode(String dosename) async {
    final dio = await authDioWithContext();

    final exceptKorean = RegExp(r"[^가-힣]");
    final processedName = dosename.replaceAll(exceptKorean, "");

    final Uri url = Uri.parse("/dose/name").replace(queryParameters: {
      "dosename": processedName,
    });

    try {
      var response = await dio.get(url.toString());

      if (response.statusCode == 200) {
        return DoseNameCodeModel(
          name: dosename,
          atcCode: response.data["data"]["atcCode"],
          kdCode: response.data["data"]["kdCode"],
        );
      } else {
        assert(false, "🚨 [Status Code Is Wrong] Check called API is correct.");
        return null;
      }
    } on DioException catch (error) {
      return null;
    }
  }
}
