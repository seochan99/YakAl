import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/widgets/Calender/calendar_pill_info_view.dart';

import '../../viewModels/Calendar/calendar_viewmodel.dart';
import '../../widgets/Base/default_back_appbar.dart';
import '../../widgets/Calender/pill_calendar.dart';

class CalenderScreen extends StatelessWidget {
  CalenderScreen({Key? key}) : super(key: key);

  final CalendarViewModel viewModel = Get.put(CalendarViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(
          title: '다른 날짜 복약정보',
        ),
      ),
      body: Column(
        children: [
          PillCalendar(viewModel: viewModel),
          Container(
            width: double.infinity,
            height: 2,
            decoration: const BoxDecoration(color: Color(0xFFE9E9EE)),
          ),
          CalendarPillInfoView(viewModel: viewModel),
        ],
      ),
    );
  }
}
