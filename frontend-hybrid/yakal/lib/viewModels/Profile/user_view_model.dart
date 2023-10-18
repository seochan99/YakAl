import 'package:get/get.dart';
import 'package:yakal/utilities/api/api.dart';

import '../../models/Profile/user.dart';
import '../../utilities/enum/mode.dart';

class UserViewModel extends GetxController {
  var user = User().obs;

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
      } else {
        print("Error updating nickname: ${response.statusMessage}");
      }
    } catch (e) {
      print("Exception while updating nickname: $e");
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
      } else {
        print("Error fetching user data: ${response.statusMessage}");
      }
    } catch (e) {
      print("Exception while fetching user data: $e");
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
// 일반 모드, 라이트 모드
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

  // 보호자 정보 추가
  void addOrUpdateGuardian(String name, DateTime? birthDate) {
    user.update((val) {
      val?.guardian = Guardian(name: name, birthDate: birthDate);
    });
  }

  void removeSpecialNoteItem(String title, int index) {
    user.update((val) {
      if (val?.specialNote != null) {
        switch (title) {
          case 'underlyingConditions':
            val?.specialNote!.underlyingConditions.removeAt(index);
            break;
          case 'allergies':
            val?.specialNote!.allergies.removeAt(index);
            break;
          case 'diagnosis':
            val?.specialNote!.diagnosis.removeAt(index);
            break;
          case 'healthfood':
            val?.specialNote!.healthfood.removeAt(index);
            break;
          case 'falls':
            val?.specialNote!.falls.removeAt(index);
            break;
          default:
            break;
        }
      }
    });
  }

  Future<void> addSpecialNoteItem(String title, dynamic item) async {
    if (title == 'healthfood' || title == 'diagnosis') {
      // Making an HTTP POST request
      try {
        var dio = await authDioWithContext();
        var response =
            await dio.post("/$title", data: {"name": item as String});

        if (response.statusCode == 200 && response.data['success']) {
          user.update((val) {
            switch (title) {
              case 'healthfood':
                val?.specialNote?.healthfood.add(item);
                break;
              case 'diagnosis':
                val?.specialNote?.diagnosis.add(item);
                break;
              default:
                break;
            }
          });
        } else {
          print("Error adding health medication: ${response.statusMessage}");
        }
      } catch (e) {
        print("Exception while adding health medication: $e");
      }
      return;
    }

    user.update((val) {
      // 특이사항이 없으면 생성
      val?.specialNote ??= SpecialNote(
        underlyingConditions: [],
        allergies: [],
        falls: [],
        diagnosis: [],
        healthfood: [],
      );
      if (val?.specialNote != null) {
        switch (title) {
          case 'underlyingConditions':
            val?.specialNote!.underlyingConditions.add(item as String);
            break;
          case 'allergies':
            val?.specialNote!.allergies.add(item as String);
            break;
          case 'diagnosis':
            val?.specialNote!.diagnosis.add(item as String);
            break;
          case 'falls':
            val?.specialNote!.falls.add(item as DateTime);
            break;
          default:
            break;
        }
      }
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
