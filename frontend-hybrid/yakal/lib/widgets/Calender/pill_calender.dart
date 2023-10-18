import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yakal/models/Calendar/calendar_day.dart';
import 'package:yakal/viewModels/Calendar/calendar_viewmodel.dart';

import 'pill_calender_day_item.dart';

class PillCalender extends StatefulWidget {
  final CalendarViewModel viewModel;
  const PillCalender(this.viewModel, {Key? key}) : super(key: key);

  @override
  State<PillCalender> createState() => _PillCalenderState();
}

class _PillCalenderState extends State<PillCalender> {
  // List<String> days = ['_', '일', '월', '화', '수', '목', '금', '토'];
  static CalendarFormat _calendarFormat = CalendarFormat.week;

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
            focusedDay: widget.viewModel.calendarDate.focusedDate,
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
              return isSameDay(widget.viewModel.calendarDate.selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(
                  widget.viewModel.calendarDate.selectedDate, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  widget.viewModel
                      .onClickCalendarItem(selectedDay)
                      .then((value) => null);
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
                widget.viewModel
                    .changeFocusedDate(focusedDay)
                    .then((value) => null);
              });
            },
            calendarBuilders: CalendarBuilders(
              todayBuilder: (context, day, focusedDay) {
                return PillCalenderDayItem(
                    date: day,
                    isSelected: false,
                    calendarDay: widget.viewModel.calendarDays[
                            DateFormat('yyyy-MM-dd').format(day)] ??
                        CalendarDay(progress: 0, isOverlap: false));
              },
              selectedBuilder: (context, day, focusedDay) {
                return PillCalenderDayItem(
                    date: day,
                    isSelected: true,
                    calendarDay: widget.viewModel.calendarDays[
                            DateFormat('yyyy-MM-dd').format(day)] ??
                        CalendarDay(progress: 0, isOverlap: false));
              },
              defaultBuilder: (context, day, focusedDay) {
                return PillCalenderDayItem(
                    date: day,
                    isSelected: false,
                    calendarDay: widget.viewModel.calendarDays[
                            DateFormat('yyyy-MM-dd').format(day)] ??
                        CalendarDay(progress: 0, isOverlap: false));
              },
              outsideBuilder: (context, day, focusedDay) {
                return Opacity(
                    opacity: 0.5,
                    child: PillCalenderDayItem(
                        date: day,
                        isSelected: false,
                        calendarDay: widget.viewModel.calendarDays[
                                DateFormat('yyyy-MM-dd').format(day)] ??
                            CalendarDay(progress: 0, isOverlap: false)));
              },
            ),
          ),
        ));
  }

  CalendarDay getCalendarDay(DateTime date) {
    return widget
            .viewModel.calendarDays[DateFormat('yyyy-MM-dd').format(date)] ??
        CalendarDay(progress: 0, isOverlap: false);
  }
}
