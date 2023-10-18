class CountModel {
  int totalCount;
  int takenCount;

  CountModel({
    required this.totalCount,
    required this.takenCount,
  });

  int getProgress() {
    return totalCount == 0 ? 0 : (takenCount * 100 ~/ totalCount);
  }
}
