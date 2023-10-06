import 'package:flutter/material.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

class MedicationOcrGeneralScreen extends StatelessWidget {
  const MedicationOcrGeneralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: "일반 의약품 추가"),
      ),
      body: Container(
        color: Colors.white,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(20, 88, 20, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
