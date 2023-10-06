import 'package:yakal/provider/Calendar/calendar_providar.dart';

class CalendarRepository {
  // ViewModel과 Providar의 중간 다리 역할
  final CalendarProvider _calendarProvider;

  CalendarRepository(this._calendarProvider);
}
