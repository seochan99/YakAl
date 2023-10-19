import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yakal/models/Medication/search_medicine_model.dart';

class MedicationDirectProvider {
  Future<List<SearchMedicineModel>> searchMedicine(String keyword) async {
    final Dio dio = Dio();

    final Uri url = Uri.parse("${dotenv.env['KIMS_SERVER_HOST']}/search/list")
        .replace(queryParameters: {
      "keyword": keyword,
      "mode": "1",
      "pageNo": "1",
    });

    String username = dotenv.env['KIMS_SERVER_USERNAME'] ?? "";
    String password = dotenv.env['KIMS_SERVER_PASSWORD'] ?? "";

    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await dio.get(
      url.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      if (jsonResponse.containsKey("List")) {
        List<dynamic> list = jsonResponse["List"];
        return list
            .map((medicineJson) => SearchMedicineModel.fromJson(medicineJson))
            .toList();
      } else {
        throw Exception(
            "'List' key not found in JSON response or unable to parse JSON response");
      }
    } else {
      throw Exception("Failed to fetch medicines.");
    }
  }
}
