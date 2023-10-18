import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yakal/utilities/api/api.dart';

import '../../models/Profile/user.dart';

class UserViewModel extends GetxController {
  var user = User().obs;

  // 로그아웃이나 유효하지 않은 토큰
  void reset() {
    user.update((val) {
      val?.reset();
    });
  }

  Future<void> fetchNameAndMode(BuildContext context) async {
    await user.value.fetch(context);
    user.refresh();
  }

  // 유저 이름 업데이트하기
  Future<void> updateNickName(String newNickName) async {
    try {
      var dio = await authDioWithContext();
      var response =
          await dio.patch("/user/name", data: {"nickname": newNickName});

      if (response.statusCode == 200) {
        // Update local user object if server update was successful
        user.update((val) {
          val?.setNickname(newNickName);
        });
      }
    } catch (e) {
      throw Exception("Exception while updating nickname: $e");
    }
  }

  // 유저 정보 가져오기
  Future<void> fetchUserData() async {
    try {
      var dio = await authDioWithContext();

      var response = await dio.get("/user");
      if (response.statusCode == 200 && response.data['success']) {
        user.update((val) {
          val?.updateFromApiResponse(response.data['data']);
        });
      }
    } catch (e) {
      throw Exception("Exception while updating nickname: $e");
    }
  }

  // 일반 모드, 라이트 모드
  Future<void> updateMode(bool newMode) async {
    try {
      var dio = await authDioWithContext();

      var response =
          await dio.patch("/user/detail", data: {"isDetail": newMode});

      if (response.statusCode == 200 && response.data['success']) {
        user.update((val) {
          val?.setMode(response.data['data']['isDetail']);
        });
      } else {}
    } catch (e) {
      // print("Exception while updating mode: $e");
    }
  }

// 복약 알림 설정
  Future<void> updateNotification(bool mode) async {
    try {
      var dio = await authDioWithContext();

      var response = await dio
          .patch("/user/notification", data: {"isAllowedNotification": mode});

      if (response.statusCode == 200 && response.data['success']) {
        user.update((val) {
          val?.setNoti(mode);
        });
      } else {}
    } catch (e) {
      // print("Exception while updating mode: $e");
    }
  }

  // 마케팅 정보 동의 여부
  void updateMarketingAgreement(bool isAgreed) {
    user.update((val) {
      val?.setIsiAgreedMarketing(isAgreed);
    });
  }

  // 보호자 정보 추가
  void addOrUpdateGuardian(String name, DateTime? birthDate) {
    user.update((val) {
      val?.guardian = Guardian(name: name, birthDate: birthDate);
    });
  }

  // 입원기록 추가
  void addHospitalRecord(DateTime admissionDate, String location) {
    user.update((val) {
      val?.hospitalRecordList ??= HospitalRecordList(
        admissionRecords: [],
        emergencyRoomVisits: [],
      );

      val?.hospitalRecordList?.admissionRecords.add(
        HospitalRecord(date: admissionDate, location: location),
      );
    });
  }

  // 입원기록 삭제
  void removeHospitalRecord(int index) {
    user.update((val) {
      val?.hospitalRecordList?.admissionRecords.removeAt(index);
    });
  }

  // 응급실 기록 추가
  void addEmergencyRoomVisit(DateTime admissionDate, String location) {
    user.update((val) {
      val?.hospitalRecordList ??= HospitalRecordList(
        admissionRecords: [],
        emergencyRoomVisits: [],
      );

      val?.hospitalRecordList?.emergencyRoomVisits.add(
        HospitalRecord(date: admissionDate, location: location),
      );
    });
  }

  // 응급실 기록 삭제
  void removeEmergencyRoomVisit(int index) {
    user.update((val) {
      val?.hospitalRecordList?.emergencyRoomVisits.removeAt(index);
    });
  }
}
