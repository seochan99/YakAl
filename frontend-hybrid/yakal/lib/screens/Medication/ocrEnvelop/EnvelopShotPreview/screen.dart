import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/back_confirm_dialog.dart';
import 'package:yakal/widgets/Base/customized_back_app_bar.dart';
import 'package:yakal/widgets/Base/outer_frame.dart';

class EnvelopShotPreviewScreen extends StatefulWidget {
  const EnvelopShotPreviewScreen({super.key});

  @override
  State<EnvelopShotPreviewScreen> createState() =>
      _EnvelopShotPreviewScreenState();
}

class _EnvelopShotPreviewScreenState extends State<EnvelopShotPreviewScreen> {
  late final String imagePath;

  @override
  void initState() {
    super.initState();

    imagePath = Get.arguments["path"];
  }

  @override
  Widget build(BuildContext context) {
    return OuterFrame(
      outOfSafeAreaColor: ColorStyles.white,
      safeAreaColor: ColorStyles.white,
      appBar: CustomizedBackAppBar(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
            builder: (BuildContext context) {
              return BackConfirmDialog(
                question: "다시 촬영하시겠습니까?",
                backTo: "/pill/add/ocrEnvelop/shot",
                backAction: () {
                  File(imagePath).delete();
                },
              );
            },
          );
        },
        title: "촬영된 약 봉투 검토",
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Image.file(File(imagePath)),
        ),
      ),
    );
  }
}
