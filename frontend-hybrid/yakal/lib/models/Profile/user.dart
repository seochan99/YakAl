import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/enum/mode.dart';

class User {
  String nickName;
  EMode mode;
  bool? isAgreedMarketing;
  Guardian? guardian;
  HospitalRecordList? hospitalRecordList;
  SpecialNote? specialNote;

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    nickName = prefs.getString("NICKNAME") ?? "";

    if (prefs.getInt("MODE") != null) {
      mode = EMode.values[prefs.getInt("MODE")!];
    } else {
      mode = EMode.NONE;
    }

    if (prefs.getBool("IS_AGREED_MARKETING") != null) {
      isAgreedMarketing = prefs.getBool("IS_AGREED_MARKETING")!;
    }
  }

  Future<void> setNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("NICKNAME", nickname);
    nickName = nickname;
  }

  Future<void> setMode(EMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("MODE", mode.index);
    this.mode = mode;
  }

  Future<void> setIsiAgreedMarketing(bool isAgreed) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("IS_AGREED_MARKETING", isAgreed);
    isAgreedMarketing = isAgreed;
  }

  User({
    this.nickName = "",
    this.mode = EMode.NONE,
    this.guardian,
    HospitalRecordList? hospitalRecordList,
    SpecialNote? specialNote,
  }) {
    hospitalRecordList = hospitalRecordList ??
        HospitalRecordList(
          admissionRecords: [],
          emergencyRoomVisits: [],
        );
    specialNote = specialNote ??
        SpecialNote(
          underlyingConditions: [],
          allergies: [],
          falls: [],
          oneYearDisease: [],
          healthMedications: [],
        );
    _init();
  }
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
  List<DateTime> falls;
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
