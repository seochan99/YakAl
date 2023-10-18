import 'package:intl/intl.dart';
import 'package:yakal/models/Calendar/calendar_day.dart';
import 'package:yakal/provider/Calendar/calendar_provider.dart';

import '../../utilities/util/date_time_util.dart';

class CalendarRepository {
  // ViewModel과 Providar의 중간 다리 역할
  final CalendarProvider _calendarProvider;

  CalendarRepository({required CalendarProvider calendarProvider})
      : _calendarProvider = calendarProvider;

  Future<Map<String, CalendarDay>> readCalendarInformation(
      DateTime date) async {
    DateTime firstDayOfCalendar = DateTimeUtil.getFirstDayOfCalendar(date);
    DateTime lastDayOfCalendar = DateTimeUtil.getLastDayOfCalendar(date);

    List<dynamic> response = await _calendarProvider.getCalendarInfoBetweenDate(
        firstDayOfCalendar, lastDayOfCalendar);

    Map<String, CalendarDay> calendarDays = {};

    for (Map<String, dynamic> item in response) {
      calendarDays[item['date']] = CalendarDay.fromJson(item);
    }

    return calendarDays;
  }
}
