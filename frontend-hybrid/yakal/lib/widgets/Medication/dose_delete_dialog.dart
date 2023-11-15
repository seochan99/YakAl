import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class DoseDeleteDialog extends StatelessWidget {
  final int id;

  const DoseDeleteDialog({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: ColorStyles.white,
      backgroundColor: ColorStyles.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 40.0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "정말 해당 복용 스케줄을\n삭제하시겠습니까?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  color: ColorStyles.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 22,
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
                        child: const Text(
                          "취소",
                          style: TextStyle(
                            color: ColorStyles.gray5,
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
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: TextButton(
                        onPressed: () {
                          // API 삭제
                          Get.back();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: ColorStyles.red,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "삭제",
                          style: TextStyle(
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
