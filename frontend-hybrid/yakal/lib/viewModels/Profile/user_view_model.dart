import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yakal/utilities/api/api.dart';
import 'package:yakal/widgets/Setting/setting_time_selection_widget.dart';

import '../../models/Profile/user.dart';

class UserViewModel extends GetxController {
  var user = User().obs;

  // 로그아웃이나 유효하지 않은 토큰
  void reset() {
    user.update((val) {
      val?.reset();
    });
  }

  Future<void> fetchLoginInfo() async {
    await user.value.fetchLoginInfo();
    user.refresh();
  }

  // 유저 이름 업데이트하기
  Future<void> updateNickName(String newNickName) async {
    try {
      var dio = await authDioWithContext();
      var response =
          await dio.patch("/users/name", data: {"nickname": newNickName});

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

      var response = await dio.get("/users");
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
    var dio = await authDioWithContext();

    var response =
        await dio.patch("/users/detail", data: {"isDetail": newMode});

    if (response.statusCode == 200 && response.data['success']) {
      user.update((val) {
        val?.setMode(newMode);
      });

      // @override
      // void onClose() {
      //   Get.find<HomeViewModel>().updatePillTodoAndDate();
      //   super.onClose();
      // }

      // onClose();
    }
  }

// 복약 알림 설정
  Future<void> updateNotification(bool mode) async {
    var dio = await authDioWithContext();

    var response = await dio
        .patch("/user/notification", data: {"isAllowedNotification": mode});

    if (response.statusCode == 200 && response.data['success']) {
      user.update((val) {
        val?.setNoti(mode);
      });
    }
  }

  // 마케팅 정보 동의 여부
  Future<void> updateMarketingAgreement(bool isAgreed) async {
    var dio = await authDioWithContext();

    var response = await dio.patch("/user/optional-agreement",
        data: {"isOptionalAgreementAccepted": isAgreed});

    if (response.statusCode == 200 && response.data['success']) {
      user.update((val) {
        val?.setIsAgreedMarketing(isAgreed);
      });
    }
  }

  // 본인인증 여부
  void updateIsIdentified(bool isIdentified) {
    user.update((val) {
      val?.setIsIdentified(isIdentified);
    });
  }

// /api/v1/guardians
  Future<void> fetchGuardian() async {
    try {
      var dio = await authDioWithContext();

      var response = await dio.get("/guardians");

      print("guardians의 정보는 이와같습니다 : $response");

      if (response.statusCode == 200 && response.data['success']) {
        user.update((val) {
          val?.guardian = Guardian.fromJson(response.data['data']);
        });
      }
    } catch (e) {
      throw Exception("Exception while updating nickname: $e");
    }
  }

  Future<void> loadGuardian() async {
    try {
      await fetchGuardian();
      print("--------------------------dsads----------------------------");

      user.update((val) {
        // If 'val' or 'hospitalRecordList' is null, initialize 'hospitalRecordList'
        val?.guardian ??= Guardian(
          id: 0,
          name: "",
          birthDate: "",
        );

        // Assuming 'fetchedItems' is set by 'fetchGuardian'
        // if (fetchedItems != null) {
        //   val?.guardian.assignAll(fetchedItems);
        // } else {
        //   print("Warning: fetchedItems is null");
        // }
      });
    } catch (e) {
      throw Exception("Exception while adding health medication: $e");
    }
  }

  // 보호자 정보 추가, id만 전달
  Future<void> addOrUpdateGuardian(int id) async {
    try {
      var dio = await authDioWithContext();
      final response = await dio.post("/guardians/$id");
      print("addOrUpdateGuardian : $response");
      loadGuardian();

      if (response.statusCode == 200) {
        print("guardianData : ${response.data}");
      } else {
        throw Exception('Failed to fetch guardian information');
      }
    } catch (e) {
      print("Error occurred: $e");
    }
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

  // 나의 시간대 GET
  Future<void> setMyTime(ETakingTime takingTime, TimeOfDay selectedTime) async {
    final String timezone = takingTime.engName;
    final TimeOfDay time = selectedTime;
    // TimeofDay의 time을 String(hh:mm:ss)으로 바꿔줘-!
    final DateFormat context = DateFormat("HH:mm:ss");
    final String formattedTime =
        context.format(DateTime(1, 1, 1, time.hour, time.minute, 0, 0, 0));

    print(formattedTime);

    try {
      var dio = await authDioWithContext();
      print("timezone $timezone");
      print("formattedTime $formattedTime");

      var response = await dio.patch("/user/notification-time",
          data: {"timezone": timezone, "time": formattedTime});

      print("fetchMyTime의 정보는 이와같습니다 : $response");

      if (response.statusCode == 200 && response.data['success']) {
        var realFormattedTime = formattedTime.substring(0, 5);
        switch (takingTime) {
          case ETakingTime.breakfast:
            user.update((val) {
              val?.breakfastTime = realFormattedTime;
            });
          case ETakingTime.lunch:
            user.update((val) {
              val?.lunchTime = realFormattedTime;
            });
          case ETakingTime.dinner:
            user.update((val) {
              val?.dinnerTime = realFormattedTime;
            });
          default:
            return;
        }
      }
    } catch (e) {
      throw Exception("Exception while updating nickname: $e");
    }
  }

  // 나의 시간대 GETter
  String getMyTime(ETakingTime takingTime) {
    switch (takingTime) {
      case ETakingTime.breakfast:
        return user.value.breakfastTime;
      case ETakingTime.lunch:
        return user.value.lunchTime;
      case ETakingTime.dinner:
        return user.value.dinnerTime;
      default:
        return "00:00";
    }
  }
}
