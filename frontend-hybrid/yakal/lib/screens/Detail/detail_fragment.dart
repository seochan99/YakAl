import 'package:flutter/material.dart';
import 'package:yakal/models/Medication/medication_detail_model.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Medication/drug_detail_section_widget.dart';

class DetailFragment extends StatelessWidget {
  final DrugInfo? drugInfo;
  final int tabIndex;

  const DetailFragment({Key? key, this.drugInfo, required this.tabIndex})
      : super(key: key);

  String getStyledText() {
    String interactionText = drugInfo?.interaction ?? "준비중 입니다!";
    return interactionText
        .replaceAll('<div style="margin-left:20px">', '')
        .replaceAll('<br>', '')
        .replaceAll('</div>', '\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorStyles.white,
        child: SingleChildScrollView(
          child: drugInfo == null
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("약 알에 등록되지 않은 약물입니다! 🥲"),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    if (tabIndex == 0) ...[
                      DurgDetailSection(
                        imageName: "assets/icons/icon-detail-pill-blue.svg",
                        title: "이러한 약물이에요!",
                        detail: drugInfo!.briefIndication,
                      ),
                      Container(
                        height: 5,
                        color: ColorStyles.gray2,
                      ),
                      DurgDetailSection(
                        imageName: "assets/icons/icon-detail-pill-gray.svg",
                        title: "복약 정보",
                        detail: drugInfo!.briefMono,
                      ),
                      Container(
                        height: 5,
                        color: ColorStyles.gray2,
                      ),
                      DurgDetailSection(
                        imageName: "assets/icons/icon-detail-food.svg",
                        title: "이런 음식/약물은 조심해요",
                        detail: getStyledText(),
                      ),
                      Container(
                        height: 5,
                        color: ColorStyles.gray2,
                      ),
                      DurgDetailSection(
                        imageName: "assets/icons/icon-detail-block.svg",
                        title: "절대 복용 금지예요",
                        detail: drugInfo!.briefMonoContraIndication,
                      ),
                      Container(
                        height: 5,
                        color: ColorStyles.gray2,
                      ),
                      DurgDetailSection(
                        imageName: "assets/icons/icon-detail-caution.svg",
                        title: "신중한 복용이 필요해요",
                        detail: drugInfo!.briefMonoSpecialPrecaution,
                      ),
                    ],
                    if (tabIndex == 1) ...[
                      DurgDetailSection(
                        imageName: "assets/icons/icon-detail-food.svg",
                        title: "이런 음식/약물은 조심해요",
                        detail: getStyledText(),
                      ),
                    ],
                    if (tabIndex == 2) ...[
                      DurgDetailSection(
                        imageName: "assets/icons/icon-detail-block.svg",
                        title: "절대 복용 금지예요",
                        detail: drugInfo!.briefMonoContraIndication,
                      ),
                    ],
                    if (tabIndex == 3) ...[
                      DurgDetailSection(
                        imageName: "assets/icons/icon-detail-caution.svg",
                        title: "신중한 복용이 필요해요",
                        detail: drugInfo!.briefMonoSpecialPrecaution,
                      ),
                    ]
                  ],
                ),
        ),
      ),
    );
  }
}
