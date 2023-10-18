import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:yakal/utilities/style/color_styles.dart';

import '../../viewModels/Home/home_view_model.dart';

class HomeInfoLayout extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomeInfoLayout(this.viewModel, {super.key});

  @override
  State<HomeInfoLayout> createState() => _HomeInfoLayoutState();
}

class _HomeInfoLayoutState extends State<HomeInfoLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 12),
                            child: Text(
                              widget.viewModel.homeInfoModel.getDate(),
                              style: const TextStyle(
                                // 글자 간격 조절
                                letterSpacing: 0,
                                fontSize: 14,
                                color: ColorStyles.gray5,
                              ),
                            ),
                          ),
                          SizedBox.fromSize(size: const Size(0, 10)),
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                            child: Text(
                              '오늘 복용해야하는 약은',
                              style: TextStyle(
                                fontSize: 20,
                                color: ColorStyles.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '총 ${widget.viewModel.homeInfoModel.totalCount}개',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: ColorStyles.main,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                ' 입니다',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: ColorStyles.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Align(
                        alignment: const AlignmentDirectional(1.00, 0.00),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 20, 30, 0),
                          child: CircularPercentIndicator(
                            percent:
                                widget.viewModel.homeInfoModel.getProgress() /
                                    100,
                            radius: 55,
                            lineWidth: 4,
                            animation: true,
                            animateFromLastPercent: true,
                            progressColor: const Color(0xFF2666F6),
                            backgroundColor: const Color(0xFFC1D2FF),
                            center: Text(
                              '${widget.viewModel.homeInfoModel.getProgress()}%',
                              style: widget.viewModel.homeInfoModel
                                          .getProgress() ==
                                      0
                                  ? const TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFFC1D2FF),
                                      fontFamily:
                                          'assets/fonts/Pretendard-Medium.otf',
                                    )
                                  : const TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF2666F6),
                                      fontFamily:
                                          'assets/fonts/Pretendard-Medium.otf',
                                    ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                /*----------------- 다른 날짜 복약정보 버튼 ----------------- */
                SizedBox.fromSize(size: const Size(0, 10)),
                Container(
                  height: 35,
                  margin: const EdgeInsetsDirectional.fromSTEB(20, 26, 0, 14),
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: ColorStyles.gray1,
                      side: const BorderSide(
                        color: ColorStyles.gray2,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed("/calendar");
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/icon-home-calendar.svg',
                    ),
                    label: const Text(
                      '다른 날짜 복약정보',
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorStyles.gray5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
