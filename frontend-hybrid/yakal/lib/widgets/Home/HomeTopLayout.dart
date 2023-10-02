import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../viewModels/Home/home_view_model.dart';

class HomeTopLayout extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeTopLayout(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                        child: Text(
                          viewModel.homeTopModel.getDate(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF626272),
                            fontFamily: 'assets/fonts/Pretendard-Medium.otf',
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                        child: Text(
                          '오늘 복용해야하는 약은',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: 'assets/fonts/Pretendard-Medium.otf',
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '총 ${viewModel.homeTopModel.totalCount}개',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFF2666F6),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'assets/fonts/Pretendard-Medium.otf',
                            ),
                          ),
                          const Text(
                            ' 입니다',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'assets/fonts/Pretendard-Medium.otf',
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
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
                      child: CircularPercentIndicator(
                        percent: viewModel.homeTopModel.getProgress() / 100,
                        radius: 44,
                        lineWidth: 4,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: const Color(0xFF2666F6),
                        backgroundColor: const Color(0xFFC1D2FF),
                        center: Text(
                          '${viewModel.homeTopModel.getProgress()}%',
                          style: viewModel.homeTopModel.getProgress() == 0
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
            Container(
              height: 35,
              margin: const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.grey[200],
                  side: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/icons/icon-home-calendar.svg',
                ),
                label: const Text(
                  '다른 날짜 복용 현황',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF626272),
                    fontFamily: 'assets/fonts/Pretendard-Medium.otf',
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
