import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yakal/widgets/Calender/pill_custom_calendar.dart';
import 'package:yakal/widgets/Home/pill_todo_layout.dart';

import '../../viewModels/Calendar/calendar_viewmodel.dart';
import '../../widgets/Calender/calendar_info_layout.dart';
import '../../widgets/Calender/pill_calendar.dart';

class CalenderScreen extends StatelessWidget {
  CalenderScreen({Key? key}) : super(key: key);

  final CalendarViewModel viewModel = Get.put(CalendarViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ///스크롤 내렸을 때 컬러
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: const [],
        title: const Text(
          '다른 날짜 복약정보',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          // CustomPillCalendar(viewModel: viewModel),
          PillCalendar(viewModel: viewModel),
          Container(
            width: double.infinity,
            height: 2,
            decoration: const BoxDecoration(color: Color(0xFFE9E9EE)),
          ),
          CalendarInfoLayout(viewModel),
          Expanded(
            child: PillTodoLayout(viewModel: viewModel, isCalendarView: true),
          ),
        ],
      ),
    );
  }
}
