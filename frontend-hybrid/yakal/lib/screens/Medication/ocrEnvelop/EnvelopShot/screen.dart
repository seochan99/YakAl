import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/screens/Medication/ocrEnvelop/EnvelopShot/style.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

import '../../../../utilities/style/color_styles.dart';

class EnvelopShotScreen extends StatefulWidget {
  const EnvelopShotScreen({super.key});

  @override
  State<EnvelopShotScreen> createState() => _EnvelopShotScreenState();
}

class _EnvelopShotScreenState extends State<EnvelopShotScreen> {
  static const double shotButtonSize = 40.0;

  CameraController? _cameraController;
  bool _isCameraReady = false;

  @override
  void initState() {
    super.initState();

    availableCameras().then(
      (List<CameraDescription> cameras) {
        if (cameras.isNotEmpty && _cameraController == null) {
          _cameraController = CameraController(
            cameras.first,
            ResolutionPreset.medium,
            enableAudio: false,
          );

          _cameraController!.initialize().then((_) {
            if (kDebugMode) {
              print("📷 [Camera Log] Camera Controller Is Initialized.");
            }

            _cameraController!
                .lockCaptureOrientation(
              DeviceOrientation.portraitUp,
            )
                .then((_) {
              if (kDebugMode) {
                print("📷 [Camera Log] Camera Orientation Is Locked.");
              }

              setState(() {
                _isCameraReady = true;
              });
            });
          });
        }
      },
    );
  }

  void _onTakePicture(
    BuildContext context,
    double shotBoxWidth,
    double shotBoxHeight,
  ) {
    _cameraController!.takePicture().then((image) {
      Get.toNamed("/pill/add/ocrEnvelop/review", arguments: {
        "path": image.path,
      });
    });
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shotBoxWidth = MediaQuery.of(context).size.width - 60.0;
    final shotBoxHeight = (shotBoxWidth * 7) / 5;

    return Scaffold(
      backgroundColor: ColorStyles.gray3,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: "약 봉투 촬영"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _cameraController != null && _isCameraReady
                  ? Stack(
                      children: [
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.srcOut),
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
                                  bottom: shotButtonSize * 3,
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
                            bottom: shotButtonSize * 3,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "약봉투를 사각형안에 위치시켜주세요.",
                                  style: EnvelopShotStyle.description,
                                ),
                                SizedBox(
                                  height: (shotBoxWidth * 7) / 5,
                                  width: shotBoxWidth,
                                  child: Stack(
                                    children: [
                                      ClipRect(
                                        clipper: _MediaSizeClipper(Size(
                                          shotBoxWidth,
                                          (shotBoxWidth * 7) / 5,
                                        )),
                                        child: Transform.scale(
                                          scale: 7 /
                                              (_cameraController!
                                                      .value.aspectRatio *
                                                  5),
                                          alignment: Alignment.topCenter,
                                          child:
                                              CameraPreview(_cameraController!),
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
                            width: shotButtonSize * 2,
                            height: shotButtonSize * 2,
                            margin:
                                const EdgeInsets.only(bottom: shotButtonSize),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(shotButtonSize),
                              color: ColorStyles.white,
                            ),
                            child: IconButton(
                              style: IconButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                              ),
                              padding: const EdgeInsets.all(0.0),
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                size: shotButtonSize * 0.9,
                              ),
                              color: ColorStyles.main,
                              onPressed: () {
                                _onTakePicture(
                                  context,
                                  shotBoxWidth,
                                  shotBoxHeight,
                                );
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
