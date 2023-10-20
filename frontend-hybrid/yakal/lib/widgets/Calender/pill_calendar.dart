import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yakal/viewModels/Calendar/calendar_viewmodel.dart';

import 'pill_calendar_day_item.dart';

class PillCalendar extends StatefulWidget {
  final CalendarViewModel viewModel;
  const PillCalendar({required this.viewModel, Key? key}) : super(key: key);

  @override
  State<PillCalendar> createState() => _PillCalendarState(viewModel: viewModel);
}

class _PillCalendarState extends State<PillCalendar> {
  // List<String> days = ['_', '일', '월', '화', '수', '목', '금', '토'];
  CalendarFormat _calendarFormat = CalendarFormat.week;
  final CalendarViewModel viewModel;

  _PillCalendarState({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          decoration: const BoxDecoration(color: Colors.white),
          child: TableCalendar(
            locale: 'ko_KR',
            firstDay:
                DateTime.now().subtract(const Duration(days: 365 * 10 + 2)),
            lastDay: DateTime.now().add(const Duration(days: 365 * 10 + 2)),
            headerStyle: const HeaderStyle(
              formatButtonVisible: true,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Colors.black,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
              formatButtonTextStyle: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            daysOfWeekHeight: 30,
            rowHeight: 75,
            focusedDay: viewModel.calendarDate.focusedDate,
            pageAnimationCurve: Curves.easeInOut,
            calendarFormat: _calendarFormat,
            availableCalendarFormats: const {
              CalendarFormat.week: '한 주씩 보기',
              CalendarFormat.month: '한 달씩 보기',
            },
            calendarStyle: const CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: true,
            ),
            selectedDayPredicate: (day) {
              return isSameDay(viewModel.calendarDate.selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(
                  viewModel.calendarDate.selectedDate, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  viewModel
                      .onClickCalendarItem(selectedDay)
                      .then((value) => print(focusedDay));
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
              setState(() {
                viewModel.changeFocusedDate(focusedDay).then((value) => null);
              });
            },
            calendarBuilders: CalendarBuilders(
              todayBuilder: (context, day, focusedDay) {
                return Obx(() => viewModel.isLoadedCalendar
                    ? Container(
                        color: Colors.white,
                        height: 75,
                        width: 30,
                      )
                    : PillCalendarDayItem(
                        date: day,
                        isSelected: false,
                        calendarDay: viewModel
                            .calendarDays[DateFormat('yyyy-MM-dd').format(day)]
                            ?.value));
              },
              selectedBuilder: (context, day, focusedDay) {
                return Obx(() => viewModel.isLoadedCalendar
                    ? Container(
                        color: Colors.white,
                        height: 75,
                        width: 30,
                      )
                    : PillCalendarDayItem(
                        date: day,
                        isSelected: true,
                        calendarDay: viewModel
                            .calendarDays[DateFormat('yyyy-MM-dd').format(day)]
                            ?.value));
              },
              defaultBuilder: (context, day, focusedDay) {
                return Obx(() => viewModel.isLoadedCalendar
                    ? Container(
                        color: Colors.white,
                        height: 75,
                        width: 30,
                      )
                    : PillCalendarDayItem(
                        date: day,
                        isSelected: false,
                        calendarDay: viewModel
                            .calendarDays[DateFormat('yyyy-MM-dd').format(day)]
                            ?.value));
              },
              outsideBuilder: (context, day, focusedDay) {
                return Obx(() => viewModel.isLoadedCalendar
                    ? Container(
                        color: Colors.white,
                        height: 75,
                        width: 30,
                      )
                    : Opacity(
                        opacity: 0.5,
                        child: PillCalendarDayItem(
                            date: day,
                            isSelected: false,
                            calendarDay: viewModel
                                .calendarDays[
                                    DateFormat('yyyy-MM-dd').format(day)]
                                ?.value)));
              },
            ),
          ),
        ));
  }
}
