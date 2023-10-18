import 'dart:convert'; // Required for base64Encode and utf8

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yakal/models/Medication/medication_detail_model.dart';

// 약 정보 불러오기 - kims
class MedicationInfoViewModel {
  final Dio _dio = Dio();

  // atc 약 코드 토대로 약 정보 불러오기
  Future<DrugInfo?> getMedicine(String code) async {
    final Uri url = Uri.parse("${dotenv.env['KIMS_SERVER_HOST']}/drug/info")
        .replace(queryParameters: {
      "drugcode": code,
      "drugType": "N",
    });

    String username = dotenv.env['KIMS_SERVER_USERNAME'] ?? "";
    String password = dotenv.env['KIMS_SERVER_PASSWORD'] ?? "";

    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await _dio.get(
      url.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
      ),
    );

    if (response.statusCode == 200) {
      return DrugInfo.fromJson(response.data['DrugInfo']);
    }
    return null;
  }
}
