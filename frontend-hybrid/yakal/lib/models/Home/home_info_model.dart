class HomeInfoModel {
  final DateTime date;
  final int totalCount;
  int takenCount;

  HomeInfoModel({
    required this.date,
    required this.totalCount,
    required this.takenCount,
  });

  int getProgress() {
    return (takenCount * 100 ~/ totalCount);
  }

  String getDate() {
    return "${date.year}년 ${date.month}월 ${date.day}일";
  }
}
