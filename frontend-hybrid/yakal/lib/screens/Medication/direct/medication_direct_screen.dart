import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchMedicineModel {
  final String name;
  final String code;

  SearchMedicineModel({required this.name, required this.code});

  factory SearchMedicineModel.fromJson(Map<String, dynamic> json) {
    return SearchMedicineModel(name: json['Name'], code: json['Code']);
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

class MedicationAddScreen extends StatefulWidget {
  const MedicationAddScreen({Key? key}) : super(key: key);

  @override
  State<MedicationAddScreen> createState() => _MedicationAddScreenState();
}

class _MedicationAddScreenState extends State<MedicationAddScreen> {
  String selectedMedicineName = '';
  String selectedMedicineCode = '';
  bool isLoading = false;

  final TextEditingController medicinController = TextEditingController();
  List<SearchMedicineModel> medicines = [];
  final BehaviorSubject<String> _searchSubject = BehaviorSubject<String>();

  _MedicationAddScreenState() {
    _searchSubject
        .debounceTime(const Duration(milliseconds: 500))
        .listen((keyword) {
      if (keyword.isNotEmpty) _searchMedicines(keyword);
    });
  }

  // 약 검색
  _searchMedicines(String keyword) async {
    setState(() {
      isLoading = true;
    });

    try {
      List<SearchMedicineModel> fetchedMedicines =
          await searchMedicine(keyword);
      setState(() {
        medicines = fetchedMedicines;
        // 로딩 끝
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    medicinController.addListener(() {
      _searchSubject.add(medicinController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchSubject.close();
  }

  void _handleButtonPress() {
    medicinController.clear();
    Get.toNamed("/pill/add/direct/result", arguments: {
      "medicin": selectedMedicineName,
      "code": selectedMedicineCode
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: "약 추가"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 약 이름 입력
                        TextField(
                          controller: medicinController,
                          decoration: InputDecoration(
                            labelText: "약 이름",
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        // 약리스트 뜸
                        const SizedBox(height: 20.0),
                        Column(
                          children: isLoading
                              ? [
                                  Center(
                                      child: Column(
                                    children: [
                                      SizedBox(
                                        // 화면 절반 길이
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                      ),
                                      const CircularProgressIndicator(),
                                    ],
                                  ))
                                ]
                              : medicines.map((medicine) {
                                  return ListTile(
                                    // medicinController.text와 같다면 배경색
                                    tileColor:
                                        medicine.name == medicinController.text
                                            ? const Color(0xff2666f6)
                                            : Colors.white,
                                    title: Text(medicine.name),
                                    subtitle: Text(medicine.code),
                                    onTap: () {
                                      selectedMedicineName = medicine.name;
                                      selectedMedicineCode = medicine.code;
                                      medicinController.text = medicine.name;
                                    },
                                  );
                                }).toList(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20.0,
                0.0,
                20.0,
                30,
              ),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: medicinController,
                builder: (context, value, child) {
                  final isButtonEnabled =
                      value.text.isNotEmpty && value.text.length > 1;

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xff2666f6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: _handleButtonPress,
                    child:
                        const Text("추가 하기", style: TextStyle(fontSize: 20.0)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
