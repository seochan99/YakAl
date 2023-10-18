import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yakal/models/Medication/medication_detail_model.dart';
import 'package:yakal/screens/Detail/detail_fragment.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Medication/medication_info_viewmodel.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

class PillDetailScreen extends StatefulWidget {
  const PillDetailScreen({super.key});

  @override
  State<PillDetailScreen> createState() => _PillDetailScreenState();
}

class _PillDetailScreenState extends State<PillDetailScreen>
    with SingleTickerProviderStateMixin {
  // 약 이름

  // name이랑 code는 porps로 받아야함
  String name = "피마펜정";
  // 약 정보 뷰모델
  final medicationInfoViewModel = MedicationInfoViewModel();
  // 약 정보
  DrugInfo? drugInfo;
  // 탭 컨트롤러
  late TabController tabController;

  @override
  void initState() {
    loadMedicineInfo();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  // 약 정보 불러오기, 현재 임시 코드 사용
  void loadMedicineInfo() async {
    DrugInfo? info = await medicationInfoViewModel.getMedicine("658700670");
    setState(() {
      // 약 정보 셋팅
      drugInfo = info;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: DefaultBackAppbar(
            title: "약 세부 정보",
          ),
        ),
        body: drugInfo == null
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: drugInfo!.identaImage == null
                                ? SvgPicture.asset(
                                    'assets/icons/icon-check-on-36.svg',
                                    width: 80,
                                    height: 40,
                                  )
                                : Image.memory(
                                    base64Decode(drugInfo!.identaImage!),
                                    width: 96,
                                    height: 48,
                                  ),
                          ),
                        ),
                        SizedBox.fromSize(size: const Size(16, 16)),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: ColorStyles.black,
                                ),
                              ),
                              SizedBox.fromSize(size: const Size(8, 8)),
                              Text(
                                drugInfo!.briefIndication!.length > 48
                                    ? "${drugInfo!.briefIndication!.substring(0, 48)}..."
                                    : drugInfo!.briefIndication ?? "",
                                style: const TextStyle(
                                  fontSize: 12,
                                  height: 1.5,
                                  color: ColorStyles.gray4,
                                ),
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  TabBar(
                    controller: tabController,
                    tabs: const [
                      Tab(
                        text: "복약 정보",
                      ),
                      Tab(
                        text: "음식/약물",
                      ),
                      Tab(
                        text: "금기",
                      ),
                      Tab(
                        text: "신중 투여",
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        DetailFragment(
                          drugInfo: drugInfo,
                          tabIndex: 0,
                        ),
                        DetailFragment(
                          drugInfo: drugInfo,
                          tabIndex: 1,
                        ),
                        DetailFragment(
                          drugInfo: drugInfo,
                          tabIndex: 2,
                        ),
                        DetailFragment(
                          drugInfo: drugInfo,
                          tabIndex: 3,
                        ),
                      ],
                    ),
                  )
                ],
              ));
  }
}
