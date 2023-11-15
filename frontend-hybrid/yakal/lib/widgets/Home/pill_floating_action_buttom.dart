import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/widgets/Base/animated_width_collapse.dart';

import '../../viewModels/Home/home_view_model.dart';

class PillFloatingActionButton extends StatelessWidget {
  static const duration = Duration(milliseconds: 300);
  final HomeViewModel viewModel;
  const PillFloatingActionButton(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            IgnorePointer(
              ignoring: !viewModel.isExpanded,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: viewModel.isExpanded
                    ? Colors.black.withOpacity(0.5)
                    : Colors.transparent,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IgnorePointer(
                    ignoring: !viewModel.isExpanded,
                    child: AnimatedOpacity(
                      opacity: viewModel.isExpanded ? 1 : 0,
                      duration: duration,
                      child: Container(
                        width: 150,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _floatItem('ocrEnvelop', '약 봉투',
                                'assets/icons/icon-envelope.svg'),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: const Color(0xFFE9E9EE),
                            ),
                            _floatItem("direct", '직접 입력',
                                'assets/icons/icon-pencil-box.svg'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      viewModel.onClickPillAddButton();
                    },
                    child: AnimatedContainer(
                      duration: duration,
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2666F6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          viewModel.isExpanded
                              ? const AnimatedRotation(
                                  duration: duration,
                                  turns: 0.125,
                                  child: Icon(Icons.add, color: Colors.white),
                                )
                              : SvgPicture.asset(
                                  'assets/icons/icon-pill.svg',
                                  width: 24,
                                  height: 24,
                                ),
                          AnimatedWidthCollapse(
                              visible: !viewModel.isExpanded,
                              duration: const Duration(milliseconds: 100),
                              child: Row(
                                children: [
                                  SizedBox.fromSize(size: const Size(10, 0)),
                                  const Text('약 추가',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ).paddingOnly(bottom: 20, right: 20)
          ],
        ));
  }
}

_floatItem(String type, String title, String imagePath) {
  return InkWell(
    onTap: () {
      Get.toNamed('/pill/add/$type');
    },
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
      child: Row(
        children: [
          SvgPicture.asset(
            imagePath,
            width: 24,
            height: 24,
          ),
          SizedBox.fromSize(size: const Size(10, 0)),
          Text(title),
        ],
      ),
    ),
  );
}
