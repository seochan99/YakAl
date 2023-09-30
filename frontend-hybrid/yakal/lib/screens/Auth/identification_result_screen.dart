import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IdentificationResultScreen extends StatefulWidget {
  const IdentificationResultScreen({super.key});

  @override
  State<IdentificationResultScreen> createState() =>
      _IdentificationResultScreenState();
}

class _IdentificationResultScreenState
    extends State<IdentificationResultScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text("${Get.arguments}");
  }
}
