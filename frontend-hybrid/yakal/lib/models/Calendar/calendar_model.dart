class CalendarInfoModel {
  DateTime selectedDate;
  DateTime focusedDate;

  CalendarInfoModel.selectedDate({
    required this.selectedDate,
  }) : focusedDate = selectedDate;

  CalendarInfoModel({
    required this.selectedDate,
    required this.focusedDate,
  });

  // copyWith 메서드 추가
  CalendarInfoModel copyWith({
    DateTime? selectedDate,
    DateTime? focusedDate,
  }) {
    return CalendarInfoModel(
      selectedDate: selectedDate ?? this.selectedDate,
      focusedDate: focusedDate ?? this.focusedDate,
    );
  }

  String getSelectedDateStr() {
    return '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일';
  }
}
