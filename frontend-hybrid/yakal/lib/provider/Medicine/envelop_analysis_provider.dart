import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:uuid/uuid.dart';

class EnvelopAnalysisProvider {
  Future<List<String>> getTextFromImage(String imagePath) async {
    var dio = Dio();

    var lastIndexOfDot = imagePath.lastIndexOf(".");
    var imageType = imagePath.substring(lastIndexOfDot + 1);

    var requestBody = <String, dynamic>{
      "version": "V1",
      "requestId": const Uuid().v4(),
      "timestamp": 0,
      "lang": "ko",
      "images": [
        {
          "format": imageType,
          "name": "medicine_envelop",
        },
      ],
    };

    var formData = FormData.fromMap(
      {
        "file": await MultipartFile.fromFile(imagePath),
        "message": MultipartFile.fromString(
          jsonEncode(requestBody),
          contentType: MediaType.parse('application/json'),
        ),
      },
      ListFormat.multiCompatible,
    );

    try {
      var response = await dio.post(
        dotenv.get("CLOVA_OCR_URL"),
        data: formData,
        options: Options(
          headers: {
            "content-Type": "multipart/form-data",
            "X-OCR-SECRET": dotenv.get("CLOVA_OCR_SECRET_KEY"),
          },
        ),
      );

      var inferList = response.data["images"][0]["fields"];
      var textList = <String>[];

      // 80% 이상의 신뢰도를 가진 string만 취함
      for (var infer in inferList) {
        if (infer["inferConfidence"] >= 0.8) {
          textList.add(infer["inferText"]);
        }
      }

      return textList;
    } on DioException catch (error) {
      return <String>[];
    }
  }
}
