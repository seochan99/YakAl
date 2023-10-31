import 'package:dio/dio.dart';
import 'package:yakal/models/Home/e_taking_time.dart';
import 'package:yakal/models/Medication/dose_group_model.dart';
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

  // API 통신으로 약 코드 알아내기
  // Future<DoseNameCodeModel?> getKDCodeAndATCCode(String dosename) async {
  //   final dio = await authDioWithContext();
  //
  //   final exceptSpace = RegExp(r"\s");
  //   final processedName = dosename.replaceAll(exceptSpace, "");
  //
  //   final Uri url = Uri.parse("/dose/name").replace(queryParameters: {
  //     "dosename": processedName,
  //   });
  //
  //   try {
  //     var response = await dio.get(url.toString());
  //
  //     if (response.statusCode == 200) {
  //       return DoseNameCodeModel(
  //         name: dosename,
  //         atcCode: response.data["data"]["atcCode"],
  //         kdCode: response.data["data"]["kdCode"],
  //       );
  //     } else {
  //       assert(false, "🚨 [Status Code Is Wrong] Check called API is correct.");
  //       return null;
  //     }
  //   } on DioException catch (error) {
  //     final koreanRegex = RegExp(r"[가-힣]");
  //     final lastKorIndex = processedName.lastIndexOf(koreanRegex);
  //     final processedInFail = processedName.substring(0, lastKorIndex + 1);
  //
  //     final Uri urlInFail = Uri.parse("/dose/name").replace(queryParameters: {
  //       "dosename": processedInFail,
  //     });
  //
  //     try {
  //       var responseInFail = await dio.get(urlInFail.toString());
  //
  //       if (responseInFail.statusCode == 200) {
  //         return DoseNameCodeModel(
  //           name: dosename,
  //           atcCode: responseInFail.data["data"]["atcCode"],
  //           kdCode: responseInFail.data["data"]["kdCode"],
  //         );
  //       } else {
  //         assert(
  //             false, "🚨 [Status Code Is Wrong] Check called API is correct.");
  //         return null;
  //       }
  //     } on DioException catch (error) {
  //       return null;
  //     }
  //   }
  // }

  Future<int> getDefaultPrescriptionId() async {
    var dio = await authDioWithContext();

    try {
      var response = await dio.get("/prescription");

      if (response.statusCode == 200) {
        return response.data["data"][0]["id"];
      } else {
        assert(false, "🚨 [Status Code Is Wrong] Check called API is correct.");
        return -1;
      }
    } on DioException catch (error) {
      return -1;
    }
  }

  Future<EAddScheduleResult> addSchedule(
    List<DoseGroupModel> groupList,
    int prescriptionId,
    DateTime start,
    DateTime end,
  ) async {
    var requestBody = <String, dynamic>{
      "prescriptionId": prescriptionId,
      "medicines": [],
    };

    for (var group in groupList) {
      for (var dose in group.doseList) {
        var schedule = <String, dynamic>{
          "KDCode": "${dose.kdCode}",
          "ATCCode": "${dose.atcCode}",
          "schedules": [],
        };

        for (var i = 0; i < end.difference(start).inDays + 1; ++i) {
          var now = start.add(Duration(days: i));
          for (var j = 0; j < 4; ++j) {
            if (group.takingTime[j]) {
              schedule["schedules"].add(<String, dynamic>{
                "date":
                    "${now.year}-${now.month < 10 ? "0${now.month}" : now.month}-${now.day < 10 ? "0${now.day}" : now.day}",
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
      var response = await dio.post("/dose", data: requestBody);

      if (response.statusCode == 201) {
        var resultList = response.data["data"];

        for (var resultItem in resultList) {
          if (!resultItem) {
            return EAddScheduleResult.PARTIALLY_SUCCESS;
          }
        }

        return EAddScheduleResult.SUCCESS;
      } else {
        assert(false, "🚨 [Status Code Is Wrong] Check called API is correct.");
        return EAddScheduleResult.FAIL;
      }
    } on DioException catch (error) {
      return EAddScheduleResult.FAIL;
    }
  }
}
