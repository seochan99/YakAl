import SwiftUI

//MARK: - Day Model
struct DayModel: Identifiable,Hashable {
    let id = UUID()
    let date: Date
    let medications: [Medicine] // List of medications for the day
    
    // 일자로 변경
    var dayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    // 한국어 요일 변환
    var weekdayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_KR") // 한국어 로케일 설정
        return formatter.string(from: date)
    }
    // 하류 약 섭취률
    var medicineIntakeRate: Double {
        let takenCount = medications.filter { $0.isTaken }.count
        return Double(takenCount) / Double(medications.count)
    }
}

extension DayModel {
    init(currentDate: Date) {
        self.date = currentDate
        self.medications = []  // 현재 날짜에 해당하는 약물 데이터를 설정하십시오.
    }
}
