import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/models/Medication/dose_group_model.dart';
import 'package:yakal/models/Medication/search_medicine_model.dart';
import 'package:yakal/utilities/api/api.dart';
import 'package:yakal/utilities/enum/add_schedule_result.dart';

class AddMedicineProvider {
  Future<String?> getMedicineBase64Image(String kimsCode) async {
    final dio = kimsDio();

    final Uri url = Uri.parse("/drug/info").replace(queryParameters: {
      "drugcode": kimsCode,
      "drugType": "K",
    });

    try {
      final response = await dio.get(url.toString());

      Map<String, dynamic> jsonResponse = response.data;

      String image = jsonResponse['DrugInfo']['IdentaImage'] ?? "";
      return image;
    } on DioException {
      return null;
    }
  }

  Future<int> getDefaultPrescriptionId() async {
    var dio = await authDioWithContext();

    try {
      var response = await dio.get("/prescriptions");

      if (response.statusCode == 200) {
        return response.data["data"][0]["id"];
      } else {
        assert(false, "🚨 [Status Code Is Wrong] Check called API is correct.");
        return -1;
      }
    } on DioException {
      return -1;
    }
  }

  Future<EAddScheduleResult> addSchedule(
    List<DoseGroupModel> groupList,
    DateTime start,
    DateTime end,
  ) async {
    var requestBody = <String, dynamic>{
      "prescriptionId": null,
      "medicines": [],
    };

    for (var group in groupList) {
      for (var dose in group.doseList) {
        var schedule = <String, dynamic>{
          "KDCode": dose.kdCode,
          "ATCCode": dose.atcCode,
          "schedules": [],
        };

        for (var i = 0; i < end.difference(start).inDays + 1; ++i) {
          var now = start.add(Duration(days: i));
          for (var j = 0; j < 4; ++j) {
            if (group.takingTime[j]) {
              schedule["schedules"].add(<String, dynamic>{
                "date": DateFormat('yyyy-MM-dd').format(now),
                "time": ETakingTime.values[j]
                    .toString()
                    .substring("ETakingTime.".length),
                "count": 1.0,
              });
            }
          }
        }

        if (schedule["schedules"].isNotEmpty) {
          requestBody["medicines"].add(schedule);
        }
      }
    }

    var dio = await authDioWithContext();

    try {
      var response = await dio.post("/prescriptions/doses", data: requestBody);

      var resultList = response.data["data"];

      for (var resultItem in resultList) {
        if (!resultItem) {
          return EAddScheduleResult.PARTIALLY_SUCCESS;
        }
      }

      return EAddScheduleResult.SUCCESS;
    } on DioException {
      return EAddScheduleResult.FAIL;
    }
  }

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

    try {
      final response = await dio.get(
        url.toString(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': basicAuth,
          },
        ),
      );

      Map<String, dynamic> jsonResponse = response.data;
      if (jsonResponse.containsKey("List")) {
        List<dynamic> list = jsonResponse["List"];
        return list
            .map((medicineJson) => SearchMedicineModel.fromJson(medicineJson))
            .toList();
      } else {
        return [];
      }
    } on DioException {
      return [];
    }
  }

  Future<String?> getBase64ImageFromName(String name) async {
    final searchResponse = await searchMedicine(name);

    if (searchResponse.isEmpty) {
      return null;
    }

    return await getMedicineBase64Image(searchResponse[0].code);
  }
}
