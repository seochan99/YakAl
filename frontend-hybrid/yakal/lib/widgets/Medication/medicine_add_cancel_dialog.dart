import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utilities/style/color_styles.dart';

class MedicineAddCancelDialog extends StatelessWidget {
  final String question;
  final String confirmLabel;
  final String cancelLabel;
  // confirm action
  final Function() onConfirm;

  const MedicineAddCancelDialog(
      {super.key,
      required this.question,
      required this.confirmLabel,
      required this.cancelLabel,
      required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorStyles.white,
      surfaceTintColor: ColorStyles.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 40.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 16,
              ),
              Text(
                question,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  height: 1.6,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: ColorStyles.gray2,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        // cacnel
                        child: Text(
                          cancelLabel,
                          style: const TextStyle(
                            color: ColorStyles.gray6,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  // confirm
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: TextButton(
                        onPressed: () {
                          onConfirm();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: ColorStyles.red,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          confirmLabel,
                          style: const TextStyle(
                            color: ColorStyles.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
