import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

class DirectAddMedicineModel {
  final String name;
  final String code;

  DirectAddMedicineModel({required this.name, required this.code});

  factory DirectAddMedicineModel.fromJson(Map<String, dynamic> json) {
    return DirectAddMedicineModel(name: json['Name'], code: json['Code']);
  }
}

// 약 코드 토대로 약 이미지 불러오기
Future<String?> getMedicin(String code) async {
  final Dio dio = Dio();

  final Uri url = Uri.parse("${dotenv.env['KIMS_SERVER_HOST']}/drug/info")
      .replace(queryParameters: {
    "drugcode": code,
    "drugType": "K",
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

    String image = jsonResponse['DrugInfo']['IdentaImage'] ?? "";
    return image;
  }
  return null;
}

class MedicationDirectResult extends StatelessWidget {
  MedicationDirectResult({super.key});
  // arguments get
  final String name = Get.arguments['medicin'];
  final String code = Get.arguments['code'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: "약 추가"),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "복약 기간과 시간을\n설정해주세요",
                  style: TextStyle(
                    color: ColorStyles.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            Row(
              children: [
                code.isNotEmpty
                    ? FutureBuilder<String?>(
                        future: getMedicin(code),
                        builder: (BuildContext context,
                            AsyncSnapshot<String?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData &&
                                snapshot.data != null &&
                                snapshot.data!.isNotEmpty) {
                              return Image.memory(
                                base64Decode(snapshot.data!),
                                width: 80,
                                height: 40,
                              );
                            } else {
                              return SvgPicture.asset(
                                "assets/icons/icon-health.svg",
                                width: 80,
                                height: 40,
                              );
                            }
                          }
                          return const CircularProgressIndicator(
                            color: ColorStyles.main,
                          );
                        },
                      )
                    : SvgPicture.asset(
                        "assets/icons/icon-health.svg",
                        width: 80,
                        height: 40,
                      ),
                const SizedBox(
                  width: 10,
                ),
                Text(name),

                // kims에서 약 이미지 불러오기
              ],
            ),
            // kims에서 약 이미지 불러오기
          ],
        ),
      ),
    );
  }
}
