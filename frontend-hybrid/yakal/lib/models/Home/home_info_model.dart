class HomeInfoModel {
  late final DateTime date;
  int totalCount;
  int takenCount;

  HomeInfoModel({
    required this.date,
    required this.totalCount,
    required this.takenCount,
  });

  int getProgress() {
    return totalCount == 0 ? 0 : (takenCount * 100 ~/ totalCount);
  }

  String getDate() {
    return "${date.year}년 ${date.month}월 ${date.day}일";
  }
}
