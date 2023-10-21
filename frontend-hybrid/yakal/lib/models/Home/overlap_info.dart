class OverlapInfo {
  final String atcCode;
  final List<String> kdCodeList;

  OverlapInfo({
    required this.atcCode,
    required this.kdCodeList,
  });

  factory OverlapInfo._fromJson(Map<String, dynamic> json) {
    return OverlapInfo(
      atcCode: json['atccode'],
      kdCodeList: List<String>.from(json['kdcodes']),
    );
  }

  static List<OverlapInfo> fromJsonList(List<dynamic> json) {
    List<OverlapInfo> overlapInfoList = [];

    for (var overlapInfo in json) {
      overlapInfoList.add(OverlapInfo._fromJson(overlapInfo));
    }

    return overlapInfoList;
  }
}
