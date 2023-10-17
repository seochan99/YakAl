import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yakal/models/Medication/medication_detail_model.dart';

class DetailFragment extends StatelessWidget {
  final DrugInfo? drugInfo;

  const DetailFragment({Key? key, this.drugInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: drugInfo == null
            ? const Center(child: Text("약 알에 등록되지 않은 약물입니다! 🥲"))
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                    // Text
                    children: [
                      const PillDetailComponent(
                        imageName: "assets/icons/icon-detail-pill-blue.svg",
                        text: "이러한 약물이에요!",
                      ),
                      Text(drugInfo!.briefIndication),
                    ]),
              ),
      ),
    );
  }
}

class PillDetailComponent extends StatelessWidget {
  final String imageName;
  final String text;

  const PillDetailComponent(
      {super.key, required this.imageName, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          imageName,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'SUIT',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(20, 20, 20, 1), // Approximately 0.08 in RGB
            ),
          ),
        ),
      ],
    );
  }
}
