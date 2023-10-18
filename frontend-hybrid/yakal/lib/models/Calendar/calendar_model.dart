class CalendarDate {
  DateTime selectedDate;
  DateTime focusedDate;

  CalendarDate.selectedDate({
    required this.selectedDate,
  }) : focusedDate = selectedDate;

  CalendarDate({
    required this.selectedDate,
    required this.focusedDate,
  });

  // copyWith 메서드 추가
  CalendarDate copyWith({
    DateTime? selectedDate,
    DateTime? focusedDate,
  }) {
    return CalendarDate(
      selectedDate: selectedDate ?? this.selectedDate,
      focusedDate: focusedDate ?? this.focusedDate,
    );
  }

  String getSelectedDateStr() {
    return '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일';
  }
}
