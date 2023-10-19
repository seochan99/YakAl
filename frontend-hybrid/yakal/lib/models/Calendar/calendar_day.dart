class CalendarDay {
  int progress;
  final bool isOverlap;

  CalendarDay({
    required this.progress,
    required this.isOverlap,
  });

  CalendarDay.fromJson(Map<String, dynamic> json)
      : progress = json['progressOrNull'],
        isOverlap = json['isOverlapped'];

  @override
  String toString() {
    // TODO: implement toString
    return 'progress: $progress, isOverlap: $isOverlap';
  }
}
