import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Medication/ocrEnvelop/EnvelopShot/style.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Medication/envelop_shot_view_model.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

class EnvelopShotScreen extends StatefulWidget {
  const EnvelopShotScreen({super.key});

  @override
  State<EnvelopShotScreen> createState() => _EnvelopShotScreenState();
}

class _EnvelopShotScreenState extends State<EnvelopShotScreen> {
  final envelopShotViewModel = Get.put(EnvelopShotViewModel());

  @override
  void initState() {
    super.initState();
    envelopShotViewModel.prepareCamera();
  }

  @override
  void dispose() {
    envelopShotViewModel.disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shotBoxWidth = MediaQuery.of(context).size.width - 60.0;
    final shotBoxHeight = shotBoxWidth * EnvelopShotViewModel.windowRatio;

    return Scaffold(
      backgroundColor: ColorStyles.gray3,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: "약 봉투 촬영"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: envelopShotViewModel.cameraReady
                    ? Stack(
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5),
                              BlendMode.srcOut,
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    backgroundBlendMode: BlendMode.dstOut,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: EnvelopShotViewModel
                                        .windowBottomPadding,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          "약봉투를 사각형안에 위치시켜주세요.",
                                          style: EnvelopShotStyle.description,
                                        ),
                                        Container(
                                          height: shotBoxHeight,
                                          width: shotBoxWidth,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: EnvelopShotViewModel.windowBottomPadding,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "약봉투를 사각형안에 위치시켜주세요.",
                                    style: EnvelopShotStyle.description,
                                  ),
                                  SizedBox(
                                    height: shotBoxHeight,
                                    width: shotBoxWidth,
                                    child: Stack(
                                      children: [
                                        ClipRect(
                                          clipper: _MediaSizeClipper(Size(
                                            shotBoxWidth,
                                            shotBoxHeight,
                                          )),
                                          child: Transform.scale(
                                            scale: 16 /
                                                (envelopShotViewModel
                                                        .cameraRatio *
                                                    5),
                                            alignment: Alignment.center,
                                            child: envelopShotViewModel
                                                .cameraPreview,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          "assets/icons/top-left-frame.svg",
                                        ),
                                        Transform.translate(
                                          offset: Offset(shotBoxWidth - 56, 0),
                                          child: SvgPicture.asset(
                                            "assets/icons/top-right-frame.svg",
                                          ),
                                        ),
                                        Transform.translate(
                                          offset: Offset(0, shotBoxHeight - 56),
                                          child: SvgPicture.asset(
                                            "assets/icons/bottom-left-frame.svg",
                                          ),
                                        ),
                                        Transform.translate(
                                          offset: Offset(
                                            shotBoxWidth - 56,
                                            shotBoxHeight - 56,
                                          ),
                                          child: SvgPicture.asset(
                                            "assets/icons/bottom-right-frame.svg",
                                          ),
                                        ),
                                        Transform.translate(
                                          offset: Offset(
                                            shotBoxWidth / 2 - 22,
                                            shotBoxHeight / 2 - 22,
                                          ),
                                          child: SvgPicture.asset(
                                            "assets/icons/center-bead.svg",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: EnvelopShotViewModel.shotButtonSize * 2,
                              height: EnvelopShotViewModel.shotButtonSize * 2,
                              margin: const EdgeInsets.only(
                                bottom: EnvelopShotViewModel.shotButtonSize,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  EnvelopShotViewModel.shotButtonSize,
                                ),
                                color: ColorStyles.white,
                              ),
                              child: IconButton(
                                style: IconButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                ),
                                padding: const EdgeInsets.all(0.0),
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  size:
                                      EnvelopShotViewModel.shotButtonSize * 0.9,
                                ),
                                color: ColorStyles.main,
                                onPressed: () {
                                  envelopShotViewModel.onTakePicture();
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        color: ColorStyles.gray1,
                        child: const Center(
                          child: Text(
                            "카메라 준비 중입니다...",
                            style: TextStyle(
                              color: ColorStyles.gray5,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;

  const _MediaSizeClipper(this.mediaSize);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
