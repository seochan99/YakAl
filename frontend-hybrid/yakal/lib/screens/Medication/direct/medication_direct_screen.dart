import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yakal/models/Medication/search_medicine_model.dart';
import 'package:yakal/provider/Medicine/add_medicine_provider.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Medication/dose_list_view_model.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

class MedicationAddScreen extends StatefulWidget {
  const MedicationAddScreen({Key? key}) : super(key: key);

  @override
  State<MedicationAddScreen> createState() => _MedicationAddScreenState();
}

class _MedicationAddScreenState extends State<MedicationAddScreen> {
  String selectedMedicineName = '';
  String selectedMedicineCode = '';
  bool isLoading = false;

  final _addMedicineProvider = AddMedicineProvider();
  final TextEditingController medicineController = TextEditingController();
  List<SearchMedicineModel> medicines = [];
  final BehaviorSubject<String> _searchSubject = BehaviorSubject<String>();
  final doseListViewModel = Get.put(AddDoseViewModel());

  _MedicationAddScreenState() {
    _searchSubject.debounceTime(const Duration(milliseconds: 500)).listen(
      (keyword) {
        if (keyword.isNotEmpty) {
          _searchMedicines(keyword);
        }
      },
    );
  }

  // 약 검색
  _searchMedicines(String keyword) async {
    setState(() {
      isLoading = true;
    });

    try {
      List<SearchMedicineModel> fetchedMedicines =
          await _addMedicineProvider.searchMedicine(keyword);
      setState(() {
        medicines = fetchedMedicines;
        // 로딩 끝
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    medicineController.addListener(() {
      _searchSubject.add(medicineController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchSubject.close();
  }

  void _handleButtonPress() {
    setState(() {
      isLoading = true;
    });

    doseListViewModel
        .setOneItem(medicineController.text, selectedMedicineCode)
        .then((_) {
      medicineController.clear();

      setState(() {
        isLoading = false;
        selectedMedicineCode = "";
      });

      Get.toNamed(
        "/pill/add/final",
        arguments: {
          "isOcr": false,
        },
        preventDuplicates: false,
      );
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
                          controller: medicineController,
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
                                    textColor:
                                        medicine.name == medicineController.text
                                            ? ColorStyles.main
                                            : ColorStyles.black,

                                    title: Text(medicine.name),
                                    onTap: () {
                                      selectedMedicineName = medicine.name;
                                      selectedMedicineCode = medicine.code;
                                      medicineController.text = medicine.name;
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
                valueListenable: medicineController,
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
                    onPressed: isButtonEnabled ? _handleButtonPress : null,
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
