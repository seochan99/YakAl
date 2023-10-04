class User {
  String nickName;
  Guardian? guardian;
  HospitalRecordList? hospitalRecordList;
  SpecialNote? specialNote;

  User({
    required this.nickName,
    this.guardian,
    HospitalRecordList? hospitalRecordList,
    this.specialNote,
  }) : hospitalRecordList = hospitalRecordList ??
            HospitalRecordList(
              admissionRecords: [],
              emergencyRoomVisits: [],
            );
}

// 보호자
class Guardian {
  String name;
  DateTime? birthDate;

  Guardian({
    required this.name,
    this.birthDate,
  });
}

// 병원 기록
class HospitalRecord {
  DateTime date;
  String location;

  HospitalRecord({
    required this.date,
    required this.location,
  });
}

// 병원 기록 리스트
class HospitalRecordList {
  // 입원
  List<HospitalRecord> admissionRecords;
  // 응급실
  List<HospitalRecord> emergencyRoomVisits;

  HospitalRecordList({
    required this.admissionRecords,
    required this.emergencyRoomVisits,
  });
}

// 특이사항
class SpecialNote {
  List<String> underlyingConditions;
  List<String> allergies;
  List<String> falls;
  List<String> oneYearDisease;
  List<String> healthMedications;

  SpecialNote({
    required this.underlyingConditions,
    required this.allergies,
    required this.falls,
    required this.oneYearDisease,
    required this.healthMedications,
  });
}
