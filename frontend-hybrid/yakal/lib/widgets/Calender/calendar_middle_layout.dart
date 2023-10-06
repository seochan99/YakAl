import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:yakal/viewModels/canlendar_viewmodel.dart';

class CalendarMiddleLayout extends StatefulWidget {
  final CalendarViewModel viewModel;
  const CalendarMiddleLayout(this.viewModel, {Key? key}) : super(key: key);

  @override
  State<CalendarMiddleLayout> createState() => _CalendarMiddleLayoutState();
}

class _CalendarMiddleLayoutState extends State<CalendarMiddleLayout> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: const Color(0xFFF5F5F9),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.viewModel.calendarModel.getSelectedDateStr(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF626272),
                            fontFamily: 'assets/fonts/Pretendard-Medium.otf',
                          ),
                        ),
                        SizedBox.fromSize(
                          size: const Size(0, 12),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${widget.viewModel.countModel.takenCount}개',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    'assets/fonts/Pretendard-Medium.otf',
                              ),
                            ),
                            const Text(
                              ' 복용',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily:
                                    'assets/fonts/Pretendard-Medium.otf',
                              ),
                            ),
                            Text(
                              ' (${widget.viewModel.countModel.totalCount}개)',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily:
                                    'assets/fonts/Pretendard-Medium.otf',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Flexible(
                      child: Align(
                        alignment: const AlignmentDirectional(1.00, 0.00),
                        child: CircularPercentIndicator(
                          percent:
                              widget.viewModel.countModel.getProgress() / 100,
                          radius: 40,
                          lineWidth: 3,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: const Color(0xFF2666F6),
                          backgroundColor: const Color(0xFFC1D2FF),
                          center: Text(
                            '${widget.viewModel.countModel.getProgress()}%',
                            style: widget.viewModel.countModel.takenCount == 0
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
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
