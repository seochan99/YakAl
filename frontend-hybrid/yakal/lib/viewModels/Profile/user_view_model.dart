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

  // Add underlying condition to special notes
  void addUnderlyingCondition(String condition) {
    user.update((val) {
      val?.specialNote?.underlyingConditions.add(condition);
    });
  }

  // Remove underlying condition from special notes
  void removeUnderlyingCondition(String condition) {
    user.update((val) {
      val?.specialNote?.underlyingConditions.remove(condition);
    });
  }

  // Add allergy to special notes
  void addAllergy(String allergy) {
    user.update((val) {
      val?.specialNote?.allergies.add(allergy);
    });
  }

  // Remove allergy from special notes
  void removeAllergy(String allergy) {
    user.update((val) {
      val?.specialNote?.allergies.remove(allergy);
    });
  }

  // Add fall to special notes
  void addFall(String fall) {
    user.update((val) {
      val?.specialNote?.falls.add(fall);
    });
  }

  // Remove fall from special notes
  void removeFall(String fall) {
    user.update((val) {
      val?.specialNote?.falls.remove(fall);
    });
  }

  // Add hospital record
  void addHospitalRecord(DateTime admissionDate, String location) {
    user.update((val) {
      val?.hospitalRecordList?.admissionRecords.add(
        HospitalRecord(admissionDate: admissionDate, location: location),
      );
    });
  }

  // Remove hospital record
  void removeHospitalRecord(int index) {
    user.update((val) {
      val?.hospitalRecordList?.admissionRecords.removeAt(index);
    });
  }

  // Add emergency room visit
  void addEmergencyRoomVisit(DateTime admissionDate, String location) {
    user.update((val) {
      val?.hospitalRecordList?.emergencyRoomVisits.add(
        HospitalRecord(admissionDate: admissionDate, location: location),
      );
    });
  }

  // Remove emergency room visit
  void removeEmergencyRoomVisit(int index) {
    user.update((val) {
      val?.hospitalRecordList?.emergencyRoomVisits.removeAt(index);
    });
  }
}
