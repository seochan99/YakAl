class CalendarModel {
  DateTime selectedDate;
  DateTime focusedDate;

  CalendarModel.selectedDate({
    required this.selectedDate,
  }) : focusedDate = selectedDate;

  CalendarModel({
    required this.selectedDate,
    required this.focusedDate,
  });

  // copyWith 메서드 추가
  CalendarModel copyWith({
    DateTime? selectedDate,
    DateTime? focusedDate,
  }) {
    return CalendarModel(
      selectedDate: selectedDate ?? this.selectedDate,
      focusedDate: focusedDate ?? this.focusedDate,
    );
  }

  String getSelectedDateStr() {
    return '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일';
  }
}
