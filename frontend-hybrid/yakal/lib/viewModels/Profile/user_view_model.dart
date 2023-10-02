import 'package:get/get.dart';
import '../../models/Profile/user.dart';

class UserViewModel extends GetxController {
  var user = User(nickName: '약 알').obs;

  // Update nickname
  void updateNickName(String newNickName) {
    user.update((val) {
      val?.nickName = newNickName;
    });
  }

  // 보호자 정보 추가
  void addOrUpdateGuardian(String name, DateTime? birthDate) {
    user.update((val) {
      val?.guardian = Guardian(name: name, birthDate: birthDate);
    });
  }

  // 특이사항 기저질환 추가
  void addUnderlyingCondition(String condition) {
    user.update((val) {
      val?.specialNote?.underlyingConditions.add(condition);
    });
  }

  // 특이사항 기저질환 삭제
  void removeUnderlyingCondition(String condition) {
    user.update((val) {
      val?.specialNote?.underlyingConditions.remove(condition);
    });
  }

  // 특이사항 알러지 추가
  void addAllergy(String allergy) {
    user.update((val) {
      val?.specialNote?.allergies.add(allergy);
    });
  }

  // 특이사항 알러지 삭제
  void removeAllergy(String allergy) {
    user.update((val) {
      val?.specialNote?.allergies.remove(allergy);
    });
  }

  // 특이사항 낙상 추가
  void addFall(String fall) {
    user.update((val) {
      val?.specialNote?.falls.add(fall);
    });
  }

  // 특이사항 낙상 삭제
  void removeFall(String fall) {
    user.update((val) {
      val?.specialNote?.falls.remove(fall);
    });
  }

  // 입원기록 추가
  void addHospitalRecord(DateTime admissionDate, String location) {
    user.update((val) {
      val?.hospitalRecordList?.admissionRecords.add(
        HospitalRecord(admissionDate: admissionDate, location: location),
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
      val?.hospitalRecordList?.emergencyRoomVisits.add(
        HospitalRecord(admissionDate: admissionDate, location: location),
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
