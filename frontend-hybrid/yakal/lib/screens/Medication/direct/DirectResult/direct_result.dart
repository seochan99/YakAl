import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

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
      body: Center(
        child: Column(
          children: [
            Text("약 이름: $name"),
            Text("약 코드: $code"),
          ],
        ),
      ),
    );
  }
}
