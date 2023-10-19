class DateTimeUtil {
  static DateTime getFirstDayOfCalendar(DateTime date) {
    DateTime firstDay = _getFirstDayOfMonth(date);
    DateTime startOfCalendar =
        firstDay.subtract(Duration(days: firstDay.weekday % 7));

    return startOfCalendar;
  }

  static DateTime getLastDayOfCalendar(DateTime date) {
    DateTime lastDay = _getLastDayOfMonth(date);
    DateTime endOfCalendar = lastDay.add(Duration(days: 6 - lastDay.weekday));

    return endOfCalendar;
  }

  static DateTime _getFirstDayOfMonth(DateTime date) =>
      DateTime(date.year, date.month, 1);

  static DateTime _getLastDayOfMonth(DateTime date) =>
      DateTime(date.year, date.month + 1, 0);
}
