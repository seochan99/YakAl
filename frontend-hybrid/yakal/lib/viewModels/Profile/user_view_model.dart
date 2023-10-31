import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yakal/models/Profile/special_note_model.dart';
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
      val?.setIsAgreedMarketing(isAgreed);
    });
  }

  // 본인인증 여부
  void updateIsIdentified(bool isIdentified) {
    user.update((val) {
      val?.setIsIdentified(isIdentified);
    });
  }

  // 보호자 정보 추가
  void addOrUpdateGuardian(String name, DateTime? birthDate) {
    user.update((val) {
      val?.guardian = Guardian(name: name, birthDate: birthDate);
    });
  }

  /*---------------------- 데이터 패치하기 - heatrlfood, dignosis ---------------------- */
  Future<List<HospitalRecord>> fetchMedicalRecord(title) async {
    try {
      // notable-features
      var dio = await authDioWithContext();
      var response = await dio.get("/medical-records/$title");
      // print("fetchMedicalRecord: $response");
      if (response.statusCode == 200 && response.data['success']) {
        return (response.data['data'] as List<dynamic>)
            .map((e) => HospitalRecord.fromJson(e))
            .toList();
      } else {
        throw Exception(
            "Error fetching fetchMedicalRecord: ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Exception while fetching fetchMedicalRecord: $e");
    }
  }

/*---------------------- 패치시키고 로드하기 ---------------------- */
  Future<void> loadMedicalRecord(title) async {
    try {
      // item 가져오기
      List<HospitalRecord> fetchedItems = await fetchMedicalRecord(title);
      print("--------------------------dsads----------------------------");
      print("$title 의 $fetchedItems");

      // update 진행
      user.update((val) {
        // null이면 생성
        val?.hospitalRecordList ??= HospitalRecordList(
          admissionRecords: [],
          emergencyRoomVisits: [],
        );

        // switch case로 구분
        switch (title) {
          case 'hospitalization-records':
            val?.hospitalRecordList?.admissionRecords.assignAll(fetchedItems);
            break;
          case 'emergency-records':
            val?.hospitalRecordList?.emergencyRoomVisits
                .assignAll(fetchedItems);
            break;

          default:
            break;
        }
      });
    } catch (e) {
      throw Exception("Exception while adding health medication: $e");
    }
  }

  // 입원기록 추가
  Future<void> addMedicalRecord(
      DateTime admissionDate, String location, String title) async {
    dynamic dataToSend;

    try {
      // 특이사항 추가 요청을 위한 Dio 인스턴스 생성
      var dio = await authDioWithContext();

      // title이 "falls"인 경우, DateTime 타입으로 데이터를 변환
      String formattedDate = DateFormat('yyyy-MM-dd').format(admissionDate);
      dataToSend = {"hospitalName": location, "recodeDate": formattedDate};

      var response =
          await dio.post("/medical-records/$title", data: dataToSend);
      // 이후 로직 (상태 코드 검사, 사용자 업데이트 등)
      loadMedicalRecord(title);
      if (response.statusCode == 200 && response.data['success']) {
        user.update((val) {
          val?.hospitalRecordList ??
              HospitalRecordList(
                admissionRecords: [],
                emergencyRoomVisits: [],
              );
        });
      }
    } catch (e) {
      throw Exception("Exception while fetching addMedicalRecord: $e");
    }

    // val?.hospitalRecordList?.admissionRecords.add(
    //       HospitalRecord(
    //         date: admissionDate,
    //         location: location,
    //       ),
    //     );
  }

// 병원 기록 삭제
  Future<void> removeMedicalRecord(String title, int index) async {
    try {
      var dio = await authDioWithContext();
      var response = await dio.delete("/medical-records/$title/$index");
      if (response.statusCode == 200 && response.data['success']) {
        loadMedicalRecord(title);
      }
    } catch (e) {
      throw Exception("Exception while adding health medication: $e");
    }
    return;
  }

  // // 입원기록 삭제
  // void removeHospitalRecord(int index) {
  //   user.update((val) {
  //     val?.hospitalRecordList?.admissionRecords.removeAt(index);
  //   });
  // }

  // // 응급실 기록 삭제
  // void removeEmergencyRoomVisit(int index) {
  //   user.update((val) {
  //     val?.hospitalRecordList?.emergencyRoomVisits.removeAt(index);
  //   });
  // }
}
