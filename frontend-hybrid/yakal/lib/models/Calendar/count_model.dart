class CountModel {
  int totalCount;
  int takenCount;

  CountModel({
    required this.totalCount,
    required this.takenCount,
  });

  int getProgress() {
    return (takenCount * 100 ~/ totalCount);
  }
}
