import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yakal/viewModels/canlendar_viewmodel.dart';

import 'calender_day_widget.dart';

class PillCalender extends StatefulWidget {
  final CalendarViewModel viewModel;
  const PillCalender(this.viewModel, {Key? key}) : super(key: key);

  @override
  State<PillCalender> createState() => _PillCalenderState();
}

class _PillCalenderState extends State<PillCalender> {
  // List<String> days = ['_', '일', '월', '화', '수', '목', '금', '토'];
  CalendarFormat _calendarFormat = CalendarFormat.week;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: TableCalendar(
            locale: 'ko_KR',
            firstDay:
                DateTime.now().subtract(const Duration(days: 365 * 10 + 2)),
            lastDay: DateTime.now().add(const Duration(days: 365 * 10 + 2)),
            daysOfWeekHeight: 30,
            rowHeight: 75,
            focusedDay: widget.viewModel.calendarModel.focusedDate,
            pageAnimationCurve: Curves.easeInOut,
            calendarFormat: _calendarFormat,
            availableCalendarFormats: const {
              CalendarFormat.week: '한 주씩 보기',
              CalendarFormat.month: '한 달씩 보기',
            },
            calendarStyle: const CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            selectedDayPredicate: (day) {
              return isSameDay(
                  widget.viewModel.calendarModel.selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(
                  widget.viewModel.calendarModel.selectedDate, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  widget.viewModel.onClickCalendarItem(selectedDay);
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              widget.viewModel.changeFocusedDate(focusedDay);
            },
            calendarBuilders: CalendarBuilders(
              todayBuilder: (context, day, focusedDay) {
                return CalenderDayWidget(date: day, isSelected: false);
              },
              selectedBuilder: (context, day, focusedDay) {
                return CalenderDayWidget(date: day, isSelected: true);
              },
              defaultBuilder: (context, day, focusedDay) {
                return CalenderDayWidget(date: day, isSelected: false);
              },
              outsideBuilder: (context, day, focusedDay) {
                return Opacity(
                    opacity: 0.5,
                    child: CalenderDayWidget(date: day, isSelected: false));
              },
            ),
          ),
        ));
  }
}
