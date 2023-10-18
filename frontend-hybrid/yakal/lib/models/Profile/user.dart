import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yakal/utilities/api/api.dart';

import '../../utilities/enum/mode.dart';

class User {
  String nickName;
  EMode mode;
  bool? isAgreedMarketing;
  Guardian? guardian;
  HospitalRecordList? hospitalRecordList;
  SpecialNote? specialNote;

  // 스토리지에서 유저 정보 가져오기
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

  // 유저 정보 초기화, 토큰은 그대로 남아있음
  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("NICKNAME");
    prefs.remove("MODE");
    prefs.remove("IS_AGREED_MARKETING");

    nickName = "";
    mode = EMode.NONE;
    isAgreedMarketing = null;
  }

  // 유저 이름과 모드를 서버에서 가져옴
  Future<void> fetch(BuildContext context) async {
    final dio = await authDio(context);

    final response = await dio.get("/user");

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();

      nickName = response.data["data"]["nickname"];
      prefs.setString("NICKNAME", nickName);

      mode = response.data["data"]["isDetail"] ? EMode.LITE : EMode.NORMAL;
      prefs.setInt("MODE", mode.index);
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

  Future<void> setIsIdentified(bool isIdentified) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("IS_IDENTIFIED", isIdentified);
    isIdentified = isIdentified;
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
