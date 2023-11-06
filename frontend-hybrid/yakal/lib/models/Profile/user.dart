import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yakal/models/Profile/special_note_model.dart';
import 'package:yakal/utilities/api/api.dart';

class User {
  String nickName;
  bool mode;
  bool isIdentified;
  bool? isAgreedMarketing;
  bool notiIsAllowed;
  String breakfastTime;
  String lunchTime;
  String dinnerTime;
  Guardian? guardian;
  HospitalRecordList? hospitalRecordList;
  SpecialNote? specialNote;

  String get deviceToken => _deviceToken;
  String _deviceToken;

  // deviceToken을 스토리지에 설정하기
  Future<void> setDeviceToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("DEVICE_TOKEN", token);
    _deviceToken = token;
  }

  Future<void> fetchAndSetDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      setDeviceToken(token);
    }
  }

  // 스토리지에서 유저 정보 가져오기
  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    nickName = prefs.getString("NICKNAME") ?? "";
    mode = prefs.getBool("MODE") ?? true;
    isIdentified = prefs.getBool("IS_IDENTIFICATION") ?? false;
    isAgreedMarketing = prefs.getBool("IS_AGREED_MARKETING");
    notiIsAllowed = prefs.getBool("NOTI_IS_ALLOWED") ?? true;
    breakfastTime = prefs.getString("BREAKFAST_TIME") ?? "";
    lunchTime = prefs.getString("LUNCH_TIME") ?? "";
    dinnerTime = prefs.getString("DINNER_TIME") ?? "";
  }

  // 유저 정보 초기화, 토큰은 그대로 남아있음
  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("NICKNAME");
    prefs.remove("MODE");
    prefs.remove("IS_AGREED_MARKETING");

    nickName = "";
    mode = true;
    isAgreedMarketing = null;
  }

  // 유저 이름과 모드를 서버에서 가져옴
  Future<void> fetchLoginInfo() async {
    final dio = await authDioWithContext();

    final response = await dio.get("/users/check/register");

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();

      nickName = response.data["data"]["isRegistered"]["name"] as String;
      prefs.setString("NICKNAME", nickName);

      mode = response.data["data"]["isRegistered"]["isDetail"] as bool;
      prefs.setBool("MODE", mode);

      isAgreedMarketing =
      response.data["data"]["isRegistered"]["isOptionalAgreementAccepted"];
      if (isAgreedMarketing != null) {
        prefs.setBool("MODE", mode);
      } else {
        prefs.remove("MODE");
      }

      isIdentified = response.data["data"]["isRegistered"]["isIdentified"];
      prefs.setBool("IS_IDENTIFICATION", isIdentified);
    }
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
    breakfastTime = data['breakfastTime'] ?? "7:00";
    lunchTime = data['lunchTime'] ?? "11:00";
    dinnerTime = data['dinnerTime'] ?? "17:00";
    prefs.setString("NICKNAME", nickName);
    prefs.setBool("MODE", mode);
    prefs.setBool("NOTI_IS_ALLOWED", notiIsAllowed);
    prefs.setString("BREAKFAST_TIME", breakfastTime);
    prefs.setString("LUNCH_TIME", lunchTime);
    prefs.setString("DINNER_TIME", dinnerTime);
  }

  Future<void> setIsAgreedMarketing(bool isAgreed) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("IS_AGREED_MARKETING", isAgreed);
    isAgreedMarketing = isAgreed;
  }

  Future<void> setIsIdentified(bool isIdentified) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("IS_IDENTIFIED", isIdentified);
    this.isIdentified = isIdentified;
  }

  User({
    this.nickName = "약알",
    this.mode = true,
    this.isIdentified = false,
    this.guardian,
    this.notiIsAllowed = true,
    this.breakfastTime = "8:00",
    this.lunchTime = "12:00",
    this.dinnerTime = "19:00",
    String deviceToken = "",
    HospitalRecordList? hospitalRecordList,
    SpecialNote? specialNote,
  }) : _deviceToken = deviceToken {
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
  int id;
  String name;
  String birthDate;

  Guardian({
    required this.id,
    required this.name,
    required this.birthDate,
  });

  factory Guardian.fromJson(Map<dynamic, dynamic> json) {
    return Guardian(
      id: json['id'],
      name: json['name'],
      birthDate: json['birthday'],
    );
  }
}

// 전문가
class Expert {
  int id;
  String name;
  String medicalEstablishment;

  Expert({
    required this.id,
    required this.name,
    required this.medicalEstablishment,
  });

  factory Expert.fromJson(Map<dynamic, dynamic> json) {
    return Expert(
      id: json['id'],
      name: json['name'],
      medicalEstablishment: json['medicalEstablishment'],
    );
  }
}

// 병원 기록
class HospitalRecord {
  int id;
  dynamic date;
  String location;

  HospitalRecord({
    required this.id,
    required this.date,
    required this.location,
  });

  factory HospitalRecord.fromJson(Map<dynamic, dynamic> json) {
    return HospitalRecord(
      id: json['id'],
      date: json['recodeDate'],
      location: json['hospitalName'],
    );
  }
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
