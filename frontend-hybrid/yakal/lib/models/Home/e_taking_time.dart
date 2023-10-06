enum ETakingTime {
  MORNING,
  AFTERNOON,
  EVENING,
  DEFAULT,
  INVISIBLE;
}

extension ETakingTimeExtension on ETakingTime {
  String get time {
    switch (this) {
      case ETakingTime.MORNING:
        return "아침";
      case ETakingTime.AFTERNOON:
        return "점심";
      case ETakingTime.EVENING:
        return "저녁";
      case ETakingTime.DEFAULT:
        return "기타";
      case ETakingTime.INVISIBLE:
        return "빈칸";
      default:
        return "";
    }
  }
}
