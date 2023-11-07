import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EnvelopShotViewModel extends GetxController {
  static const double shotButtonSize = 30.0;
  static const double windowBottomPadding = 100.0;
  static const double windowRatio = 7 / 5;

  final Rxn<CameraController?> cameraController = Rxn<CameraController?>(null);
  final RxBool _isCameraReady = false.obs;

  bool get cameraReady =>
      cameraController.value != null && _isCameraReady.value;

  double get cameraRatio => cameraController.value!.value.aspectRatio;

  CameraPreview get cameraPreview => CameraPreview(cameraController.value!);

  void prepareCamera() {
    if (kDebugMode) {
      print("📷 [Camera Log] Start To Prepare Camera.");
    }

    availableCameras().then(
      (List<CameraDescription> cameras) {
        if (cameras.isNotEmpty && cameraController.value == null) {
          // Execute First Camera With 1920 * 1080 FHD
          // Mic Off
          cameraController.value = CameraController(
            cameras.first,
            ResolutionPreset.veryHigh,
            enableAudio: false,
          );

          cameraController.refresh();

          if (kDebugMode) {
            print("📷 [Camera Log] Some Camera Is Prepared.");
          }

          cameraController.value!.initialize().then(
            (_) {
              if (kDebugMode) {
                print("📷 [Camera Log] Camera Controller Is Initialized.");
              }

              cameraController.value!
                  .lockCaptureOrientation(DeviceOrientation.portraitUp)
                  .then(
                (_) {
                  if (kDebugMode) {
                    print(
                        "📷 [Camera Log] Camera Orientation Is Locked Into Portrait.");
                  }

                  _isCameraReady.value = true;

                  if (kDebugMode) {
                    print("📷 [Camera Log] Camera Is Ready To Use.");
                  }
                },
              );
            },
          );
        }
      },
    );
  }

  void onTakePicture() {
    cameraController.value!.takePicture().then(
      (XFile image) {
        if (kDebugMode) {
          print("📸 [Camera Log] Picture Was Taken!");
        }

        Get.toNamed(
          "/pill/add/ocrEnvelop/review",
          arguments: {
            "path": image.path,
          },
        );
      },
    ).catchError(
      (_) {
        if (kDebugMode) {
          print("📸 [Camera Log] Failed To Take Picture!");
        }
      },
    );
  }

  void disposeCamera() {
    cameraController.value!.dispose().then((_) {
      if (kDebugMode) {
        print("🗑️ [Camera Log] Camera Controller Is Disposed.");
      }
    });
  }
}
