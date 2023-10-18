import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/enum/mode.dart';

class User {
  String nickName;
  bool mode;
  bool notiIsAllowed;
  String breakfastTime;
  String lunchTime;
  String dinnerTime;
  Guardian? guardian;
  HospitalRecordList? hospitalRecordList;
  SpecialNote? specialNote;

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    nickName = prefs.getString("NICKNAME") ?? "";
    mode = true;
    notiIsAllowed = prefs.getBool("NOTI_IS_ALLOWED") ?? true;
    breakfastTime = prefs.getString("BREAKFAST_TIME") ?? "";
    lunchTime = prefs.getString("LUNCH_TIME") ?? "";
    dinnerTime = prefs.getString("DINNER_TIME") ?? "";
  }

  // 닉네임 설정
  Future<void> setNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("NICKNAME", nickname);
    nickName = nickname;
  }

  // 모드 설정
  Future<void> setMode(bool mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("MODE", mode);
  }

  // 알림 설정
  Future<void> setNoti(bool mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("NOTI_IS_ALLOWED", mode);
  }

  // api통신 후 유저 정보 업데이
  Future<void> updateFromApiResponse(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    nickName = data['nickname'] ?? "";
    mode = data['isDetail'] ?? true;
    notiIsAllowed = data['notiIsAllowed'] ?? true;
    breakfastTime = data['breakfastTime'] ?? "8:00";
    lunchTime = data['lunchTime'] ?? "12:00";
    dinnerTime = data['dinnerTime'] ?? "19:00";
    prefs.setString("NICKNAME", nickName);
    prefs.setBool("MODE", mode);
    prefs.setBool("NOTI_IS_ALLOWED", notiIsAllowed);
    prefs.setString("BREAKFAST_TIME", breakfastTime);
    prefs.setString("LUNCH_TIME", lunchTime);
    prefs.setString("DINNER_TIME", dinnerTime);
  }

  User({
    this.nickName = "약알",
    this.mode = true,
    this.guardian,
    this.notiIsAllowed = true,
    this.breakfastTime = "8:00",
    this.lunchTime = "12:00",
    this.dinnerTime = "19:00",
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
          diagnosis: [],
          healthfood: [],
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
  List<String> diagnosis;
  List<String> healthfood;

  SpecialNote({
    required this.underlyingConditions,
    required this.allergies,
    required this.falls,
    required this.diagnosis,
    required this.healthfood,
  });
}
