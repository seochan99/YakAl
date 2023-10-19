import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:yakal/screens/Medication/ocrEnvelop/EnvelopShotReview/style.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/back_confirm_dialog.dart';
import 'package:yakal/widgets/Base/bottom_button.dart';
import 'package:yakal/widgets/Base/customized_back_app_bar.dart';
import 'package:yakal/widgets/Base/outer_frame.dart';

class EnvelopShotReviewScreen extends StatefulWidget {
  const EnvelopShotReviewScreen({super.key});

  @override
  State<EnvelopShotReviewScreen> createState() =>
      _EnvelopShotReviewScreenState();
}

class _EnvelopShotReviewScreenState extends State<EnvelopShotReviewScreen> {
  late final String imagePath;

  CroppedFile? _croppedFile;

  @override
  void initState() {
    super.initState();

    imagePath = Get.arguments["path"];
  }

  Future<void> _cropImage() async {
    final File imageFile = File(imagePath);

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '자르기 및 회전',
          toolbarColor: ColorStyles.main,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: "자르기 및 회전",
          doneButtonTitle: "완료",
          cancelButtonTitle: "취소",
          showCancelConfirmationDialog: true,
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _croppedFile = croppedFile;
      });
    }
  }

  void _onTapBackButton() {
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

            if (_croppedFile != null) {
              File(_croppedFile!.path).delete();
            }
          },
        );
      },
    );
  }

  void _showExampleBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 50.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: ColorStyles.gray1,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "올바른 예시",
                      style: EnvelopShotReviewStyle.rightExampleTitle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Image.asset(
                  "assets/images/well-taken-envelop.png",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const padding = 30.0;
    final width = MediaQuery.of(context).size.width - padding * 2;

    return OuterFrame(
      outOfSafeAreaColor: ColorStyles.white,
      safeAreaColor: ColorStyles.white,
      appBar: CustomizedBackAppBar(
        onPressed: _onTapBackButton,
        title: "촬영된 약 봉투 검토",
      ),
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                width: width,
                height: width,
                decoration: BoxDecoration(
                  color: ColorStyles.sub3,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: _croppedFile != null
                    ? Image.file(File(_croppedFile!.path))
                    : Image.file(File(imagePath)),
              ),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "약 봉투가 ",
                        style: EnvelopShotReviewStyle.description,
                      ),
                      Text(
                        "올바른 방향",
                        style: EnvelopShotReviewStyle.emphasis,
                      ),
                      Text(
                        "으로 보이고",
                        style: EnvelopShotReviewStyle.description,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "사진에 ",
                        style: EnvelopShotReviewStyle.description,
                      ),
                      Text(
                        "꽉 차도록",
                        style: EnvelopShotReviewStyle.emphasis,
                      ),
                      Text(
                        " 수정해주세요!",
                        style: EnvelopShotReviewStyle.description,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 20.0,
                      ),
                      splashFactory: NoSplash.splashFactory,
                      foregroundColor: ColorStyles.gray5,
                      backgroundColor: ColorStyles.gray4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    onPressed: _showExampleBottomSheet,
                    child: const Text(
                      "예시 보기",
                      style: EnvelopShotReviewStyle.exampleButton,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 20.0,
                      ),
                      splashFactory: NoSplash.splashFactory,
                      foregroundColor: ColorStyles.sub3,
                      backgroundColor: ColorStyles.main,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    icon: const Icon(
                      Icons.crop_rotate_outlined,
                      color: ColorStyles.white,
                      size: 24,
                    ),
                    label: const Text(
                      "자르기 및 회전",
                      style: EnvelopShotReviewStyle.cropAndRotateButton,
                    ),
                    onPressed: () {
                      _cropImage();
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: BottomButton(
                      "전송",
                      onPressed: () {
                        var imagePathToSend = imagePath;

                        if (_croppedFile != null) {
                          imagePathToSend = _croppedFile!.path;
                          File(imagePath).delete();
                        }

                        Get.toNamed("/pill/add/ocrEnvelop/processs",
                            arguments: {
                              "imagePath": imagePathToSend,
                            });
                      },
                      backgroundColor: ColorStyles.main,
                      color: ColorStyles.white,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
